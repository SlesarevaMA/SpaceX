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
    private weak var presentationAssemlby: PresentationAssemlby?
    
    private let imageView = UIImageView()
    
    private var bottomSheetViewController: SheetViewController?
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private var rockets = [Rocket]()
    private var currentPage: Int = 0
    
    init(rocketInfoService: RocketInfoService, presentationAssemlby: PresentationAssemlby) {
        self.rocketInfoService = rocketInfoService
        self.presentationAssemlby = presentationAssemlby
        
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
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        var options = SheetOptions()
        options.presentingViewCornerRadius = 32
        options.pullBarHeight = 48
        
        let bottomSheet = SheetViewController(
            controller: pageViewController,
            sizes: [.percent(0.5), .percent(0.7), .percent(1)],
            options: options
        )
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomSheet.view)
        addChild(bottomSheet)
        bottomSheet.didMove(toParent: self)

        bottomSheet.resize(to: .percent(0.7), animated: false)
        bottomSheet.gripSize = .zero
        
        bottomSheetViewController = bottomSheet
    }
    
    private func requestRockets() {
        rocketInfoService.requestRocketInfo { result in
            DispatchQueue.main.async {
                self.processResult(result: result)
            }
        }
    }
    
    private func processResult(result: Result<[Rocket], RequestError>) {
        switch result {
        case .success(let results):
            rockets = results
            
            if let firstRocket = rockets.first {
                let rocketInfoViewControler = setupViewController(with: firstRocket, pageNumber: 0)
                pageViewController.setViewControllers([rocketInfoViewControler], direction: .forward, animated: false)
                setRandomImage(for: firstRocket)
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
    
    private func setupViewController(with model: Rocket, pageNumber: Int) -> RocketInfoViewController {
        guard let rocketInfoViewController = presentationAssemlby?.rocketInfoViewController() else {
            fatalError("RocketInfoViewController not created")
        }
        
        rocketInfoViewController.configure(with: model)
        rocketInfoViewController.pageNumber = pageNumber
        bottomSheetViewController?.handleScrollView(rocketInfoViewController.scrollView)
        
        return rocketInfoViewController
    }
    
    private func setRandomImage(for rocket: Rocket) {
        guard let randomImageUrl = rocket.flickrImages.randomElement() else {
            return
        }

        rocketInfoService.requestImage(at: randomImageUrl) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}

extension RocketContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard currentPage > 0 else {
            return nil
        }
        
        let rocketIndex = currentPage - 1
        let rocket = rockets[rocketIndex]
        
        return setupViewController(with: rocket, pageNumber: rocketIndex)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard currentPage < rockets.count - 1 else {
            return nil
        }
        
        let rocketIndex = currentPage + 1
        let rocket = rockets[rocketIndex]
        
        return setupViewController(with: rocket, pageNumber: rocketIndex)
    }
}

extension RocketContainerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed else {
            return
        }
  
        // Текущий viewController в viewControllers всегда первый
        let pageNumber = (pageViewController.viewControllers?.first as? RocketInfoViewController)?.pageNumber ?? 0
        
        currentPage = pageNumber
        setRandomImage(for: rockets[pageNumber])
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return rockets.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPage
    }
}
