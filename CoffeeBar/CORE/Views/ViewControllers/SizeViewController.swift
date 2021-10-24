//
//  SizeViewController.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit
import Combine

// MARK: - SizeViewController
class SizeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    
    // MARK: - Proprieties
    public var viewModel : SizeViewModel!
    private var cancellables: Set<AnyCancellable> = []
    var sessionManager : SessionManager!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCells()
        setupObservers()
    }
    
    deinit {
        cancellables.removeAll()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.applyDataSource()
    }
    
}

// MARK: - Helpers
extension SizeViewController : BaseViewControllerProtocol {
    func setupUI() {
        headerView.configureView(mode: .size)
        headerView.backButtonDidTappedCallback = { [weak self] in
            guard let self = self else { return }
            self.sessionManager.cleanSession()
            self.viewModel.removeCancellables()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Cell registration
    func registerCells() {
        let itemCell = UINib(nibName: CoffeeTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: CoffeeTableViewCell.reuseIdentifier)
    }
    
    func setupObservers() {
        viewModel.itemsDiffableDataSource = SizeTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, object in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeTableViewCell.reuseIdentifier, for: indexPath) as? CoffeeTableViewCell else {return UITableViewCell()}
            cell.setupCell(item: object, size: object.size)
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension SizeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.canSelectObject(index: indexPath.item) {
            let destination = ExtraViewController.instantiateFromStoryboard(mainStoryboard)
            destination.viewModel = ExtraViewModel(extraCoffeArray: sessionManager.extraCoffeArray, sessionManager: sessionManager)
            show(destination, sender: self)
        }
    }
}
