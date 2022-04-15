//
//  RocketContainerViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 15.04.2022.
//

import UIKit
import FittedSheets

final class RocketContainerViewController: UIViewController {
    
    private let rocketInfoService: RocketInfoService
    private let viewModelMapper: RocketInfoViewModelMapper
    
    private let imageView = UIImageView()
    private var currentRocketViewController: RocketInfoViewController?
    
    private var rockets = [RocketViewModel]()
    
    init() {
        let networkManager = NetworkManagerImpl()
        let decoder = SpaceXJSONDecoder()
        rocketInfoService = RocketInfoServiceImpl(networkManager: networkManager, decoder: decoder)
        viewModelMapper = RocketInfoViewModelMapper()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addImageView()
        addBottomSheet()
        requestRockets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = view.bounds
    }
    
    private func addImageView() {
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
    }
    
    private func addBottomSheet() {
        let rocketInfoViewController = RocketInfoViewController()
        
        var options = SheetOptions()
        options.presentingViewCornerRadius = 32
        options.pullBarHeight = 48
        
        let bottomSheet = SheetViewController(
            controller: rocketInfoViewController,
            sizes: [.percent(0.5), .percent(0.7), .percent(1)],
            options: options
        )
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomSheet.view)
        addChild(bottomSheet)
        bottomSheet.didMove(toParent: self)
        
        bottomSheet.handleScrollView(rocketInfoViewController.scrollView)
        bottomSheet.resize(to: .percent(0.7), animated: false)
        bottomSheet.gripSize = .zero
        
        currentRocketViewController = rocketInfoViewController
    }
    
    private func requestRockets() {
        rocketInfoService.requestRocketInfo { result in
            DispatchQueue.main.async {
                self.processResult(result: result)
            }
        }
    }
    
    private func processResult(result: Result<[RocketAPIModel], RequestError>) {
        switch result {
        case .success(let results):
            rockets = results.map(viewModelMapper.map(model:))
            
            if let firstRocket = rockets.first {
                currentRocketViewController?.configure(with: firstRocket)
            }
            
            if let randomImageUrl = results.first?.flickrImages.randomElement() {
                rocketInfoService.requestImage(at: randomImageUrl) { image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleError(_ error: RequestError) {
        showAlert(title: "Download fail", message: nil) {
            self.requestRockets()
        }
    }
    
    private func showAlert(title: String, message: String?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            completion()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
