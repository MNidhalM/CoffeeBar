//
//  ExtraViewController.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit
import Combine

// MARK: - ExtraControllerDelegate
protocol ExtraControllerDelegate: AnyObject {
    var subTableView: UITableView { get }
    func updateExtraState(_ extraId: String?, _ subExtraId: String?, isSelected: Bool)
}

// MARK: - ExtraViewController
class ExtraViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        viewModel.collectSelection()
        let destination = OverviewController.instantiateFromStoryboard(mainStoryboard)
        destination.sessionManager = Session.sharedInstance
        destination.viewModel = OverviewViewModel(dataArray: OverviewCoffee().array)
        show(destination, sender: self)
    }
    
    // MARK: - Proprieties
    public var viewModel : ExtraViewModel!
    private var cancellables: Set<AnyCancellable> = []
    // animate reloadtable one time
    private var shouldAnimate : Bool = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        getData()
        setupUI()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        cancellables.removeAll()
    }
}

// MARK: - BaseViewControllerProtocol
extension ExtraViewController: BaseViewControllerProtocol {
    func setupUI() {
        headerView.configureView(mode: .extra)
        headerView.backButtonDidTappedCallback = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func setupTableView(){
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    func registerCells() {
        let cell = UINib(nibName: ExtraCell.reuseIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: ExtraCell.reuseIdentifier)
    }
    
}

// MARK: - Helpers
extension ExtraViewController {
    private func getData() {
        ensureOnMainQueue {
            UIView.transition(with: self.view, duration: 0.2, options: .transitionCrossDissolve, animations: { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }, completion: { [weak self] _ in
                guard let self = self else { return }
                self.shouldAnimate = false
                self.tableView.layoutIfNeeded()
            })
        }
    }
    
}

// MARK: - UITableViewDataSource
extension ExtraViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            viewModel.isDataExistAndValid(index: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: ExtraCell.reuseIdentifier, for: indexPath) as? ExtraCell
        else { return UITableViewCell() }
        cell.updateCell(viewModel.allExtras[indexPath.row], self, animate: shouldAnimate)
        return cell
    }
    
}

// MARK: - ExtraControllerDelegate
extension ExtraViewController: ExtraControllerDelegate {
    var subTableView: UITableView { tableView }
    
    func updateExtraState(_ extraId: String?, _ subExtraId: String?, isSelected: Bool) {
        viewModel.updateFromSubExtra(extraId, subExtraId, isSelected: isSelected)
    }
}
