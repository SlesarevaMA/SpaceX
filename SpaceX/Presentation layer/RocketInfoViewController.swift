//
//  RocketInfoViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 20.03.2022.
//

import UIKit

final class RocketInfoViewController: UIViewController {
    
    private let rocketInfoView = RocketInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rocketInfoView)
        
    }    
}
