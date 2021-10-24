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
    public var viewModel : TypeViewModel!
    private var cancellables: Set<AnyCancellable> = []
    var sessionManager : SessionManager!
    @Published var animate = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    // MARK: Cell registration
    func registerCells() {
        let itemCell = UINib(nibName: CoffeeTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: CoffeeTableViewCell.reuseIdentifier)
    }
    
    func setupObservers() {
        viewModel.itemsDiffableDataSource = TypeTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, object in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeTableViewCell.reuseIdentifier, for: indexPath) as? CoffeeTableViewCell else {return UITableViewCell()}
            
            cell.setupCell(item: object, size: .large)
            return cell
        })
    }
}

// MARK: - UITableViewDelegate
extension TypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.canSelectObject(index: indexPath.item) {
            let destination = SizeViewController.instantiateFromStoryboard(mainStoryboard)
            destination.viewModel = SizeViewModel(sizeCoffeeArray: sessionManager.sizeCoffeeArray, sessionManager: sessionManager)
            destination.sessionManager = sessionManager
            show(destination, sender: self)
        }
    }
}
