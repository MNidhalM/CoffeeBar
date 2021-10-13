//
//  ScanViewController.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit
import CoreNFC
import Combine

// MARK: - ScanViewController
class ScanViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var headerView: HeaderView!
    @IBAction func helpButtonTapped(_ sender: Any) {
        ToastHelper.showToast(failure: false, message: Constants.user_test_message.rawValue, droppedUp: true)
    }
    
    // MARK: - Proprieties
    public var viewModel : ScanViewModelType!
    private var session: NFCNDEFReaderSession?
    private var nfcSession: NFCNDEFReaderSession?
    
    private let coffeeMachineId = PassthroughSubject<String, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        showToat()
    }
    
    required init?(coder: NSCoder) {
        viewModel = ScanViewModel(observer: coffeeMachineId)
        super.init(coder: coder)
    }
    
    deinit {
        cancellables.removeAll()
    }
    
}

// MARK: - Helpers
extension ScanViewController {
    private func startNFC() {
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.begin()
    }
    
    private func setupUI() {
        // setup backgroundImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // setup Header
        headerView.configureView(mode: .scan)
        
        // setup question text
        questionLabel.underline()
    }
    
    /// implement this toast to inform user how he can start with a fake machineID
    private func showToat() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ToastHelper.showToast(failure: false, message: Constants.user_test_message.rawValue, droppedUp: true)
        }
    }
    
    private func setupObservers() {
        // observe data from coffees
        viewModel.coffees
            .receive(on: RunLoop.main)
            .sink {
                print($0)
            } receiveValue: { [weak self] coffees in
                guard let self = self else { return }
                self.showCoffeeTypeViewController(with : coffees)
            }
            .store(in: &cancellables)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        startNFC()
    }
    
}

// MARK: - NFCNDEFReaderSessionDelegate
extension ScanViewController : NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // for a proof concept we start with test device id "60ba1ab72e35f2d9c786c610"
        coffeeMachineId.send(testDeviceId)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    coffeeMachineId.send(string)
                    coffeeMachineId.send(completion: .finished)
                }
            }
        }
    }
    
}

// MARK: - Navigation
extension ScanViewController {
    private func showCoffeeTypeViewController(with coffees: [TypeCoffee]) {
        let typeViewController = TypeViewController.instantiateFromStoryboard(mainStoryboard)
        navigationController?.pushViewController(typeViewController, animated: true)
    }
}
