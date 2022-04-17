//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 19.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let presentationAssemlby: PresentationAssemlby = PresenationAssemblyImpl()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: scene)
        let rocketContainerViewController = presentationAssemlby.rocketContainerViewController()
        let navigationController = UINavigationController(rootViewController: rocketContainerViewController)
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.tintColor = .white
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }

}

