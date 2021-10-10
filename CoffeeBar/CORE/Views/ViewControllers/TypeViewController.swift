//
//  ViewController.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit
import Combine

// MARK: - TypeViewController
class TypeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    
    // MARK: - Proprieties
    public var viewModel = TypeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    @Published var animate = false

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        registerCells()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.applyDataSource()
    }

    deinit {
        cancellables.removeAll()
    }
}

// MARK: - Helpers
extension TypeViewController : BaseViewControllerProtocol {
    func setupUI() {
        headerView.configureView(mode: .type)
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
        viewModel.itemsDiffableDataSource = TypeTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, object in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeTableViewCell.reuseIdentifier, for: indexPath) as? CoffeeTableViewCell else {return UITableViewCell()}
            
            cell.setupCell(item: object)
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension TypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.itemsSnapshot.numberOfItems else { return }
        let selectedItem = viewModel.itemsSnapshot.itemIdentifiers[indexPath.item]
        let sizeViewController = SizeViewController.instantiateFromStoryboard(mainStoryboard)
        SessionManager.sharedInstance.typeCoffeeSelected = selectedItem
        sizeViewController.viewModel = SizeViewModel()
        navigationController?.pushViewController(sizeViewController, animated: true)

    }
}
