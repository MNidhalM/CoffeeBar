//
//  OverViewController.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit
import Combine
import Lottie
// MARK: - OverviewController
class OverviewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: ContentSizedTableView!
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        SessionManager.sharedInstance.cleanSession()
        addBlurEffect()
        startAnimationCoffeeMchine()
        // start audio message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            AudioManager.sharedInstance.startToInstruct(with: Constants.audio_speech.rawValue)
        }
    }
    
    // MARK: - Proprieties
    public var viewModel : OverviewViewModel!
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
        viewModel.removeCancellables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.applyDataSource()
        tableView.animateTable()
    }
}

// MARK: - Helpers
extension OverviewController : BaseViewControllerProtocol {
    func setupUI() {
        headerView.configureView(mode: .size)
        
        headerView.backButtonDidTappedCallback = { [weak self] in
            guard let self = self else { return }
            self.viewModel.removeCancellables()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    func setupObservers() {
        viewModel.itemsDiffableDataSource = OverviewTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, object in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewCell.reuseIdentifier, for: indexPath) as? OverviewCell else {return UITableViewCell()}
            
            cell.setupCell(item: object, limits: (first: (indexPath.row == 0), last: (indexPath.row == (self.viewModel.dataArray.count - 1))))
            return cell
        })
    }
    
    func registerCells() {
        let itemCell = UINib(nibName: OverviewCell.reuseIdentifier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: OverviewCell.reuseIdentifier)
    }
}

// MARK: - Animation Helpers
extension OverviewController {
    // show a blur effect view
    private func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
    }
    
    // start animation with Lottie
    private func startAnimationCoffeeMchine() {
        let animationView = AnimationView(name: "coffee")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
        view.addSubview(animationView)
        animationView.play { [weak self] isTrue in
            guard let self = self else { return}
            self.navigationController?.setViewControllers([TypeViewController.instantiateFromStoryboard(mainStoryboard)], animated: true)
        }
    }
    
}
