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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        registerCells()
        setupObservers()
    }

    deinit {
        cancellables.removeAll()
        //        viewModel.removeCancellables()

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
            SessionManager.sharedInstance.cleanSession()
            self.viewModel.removeCancellables()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Configure table view
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    // MARK: Cell registration
    func registerCells() {
        let itemCell = UINib(nibName: CoffeeTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: CoffeeTableViewCell.reuseIdentifier)
    }

    func setupObservers() {
        viewModel.itemsDiffableDataSource = SizeTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, object in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeTableViewCell.reuseIdentifier, for: indexPath) as? CoffeeTableViewCell else {return UITableViewCell()}
            cell.setupCell(item: object)
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension SizeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.itemsSnapshot.numberOfItems else { return }
        let selectedItem = viewModel.itemsSnapshot.itemIdentifiers[indexPath.item]
        SessionManager.sharedInstance.sizeCoffeeSelected = selectedItem
        let extraViewController = ExtraViewController.instantiateFromStoryboard(mainStoryboard)
        extraViewController.viewModel = ExtraViewModel()
        navigationController?.pushViewController(extraViewController, animated: true)

    }
}
