//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let sizeLabel = UILabel()
    private let massLabel = UILabel()
    private let sizeSwitch = UISegmentedControl(items: ["m", "ft"])
    private let massSwitch = UISegmentedControl(items: ["kg", "lb"])
    
    private let userInfoStorage: UserInfoStorage
    
    init(userInfoStorage: UserInfoStorage) {
        self.userInfoStorage = userInfoStorage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeLabel.text = "Высота"
        massLabel.text = "Масса"
        
        view.backgroundColor = .black
        
        sizeSwitch.addTarget(self, action: #selector(sizeChanged(sender:)), for: .valueChanged)
        massSwitch.addTarget(self, action: #selector(massChanged(sender:)), for: .valueChanged)
        
        view.addSubview(sizeLabel)
        view.addSubview(massLabel)
        view.addSubview(sizeSwitch)
        view.addSubview(massSwitch)
        
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        massLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeSwitch.translatesAutoresizingMaskIntoConstraints = false
        massSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            sizeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            
            sizeSwitch.leadingAnchor.constraint(greaterThanOrEqualTo: sizeLabel.trailingAnchor, constant: 28),
            sizeSwitch.centerYAnchor.constraint(equalTo: sizeLabel.centerYAnchor),
            sizeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            massLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            massLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 40),
            
            massSwitch.leadingAnchor.constraint(greaterThanOrEqualTo: massLabel.trailingAnchor, constant: 28),
            massSwitch.centerYAnchor.constraint(equalTo: massLabel.centerYAnchor),
            massSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
        ])
    }
    
    @objc private func sizeChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userInfoStorage.setSizeUnit(.m)
        } else {
            userInfoStorage.setSizeUnit(.ft)
        }
    }
    
    @objc private func massChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userInfoStorage.setWeightUnit(.kg)
        } else {
            userInfoStorage.setWeightUnit(.lb)
        }
    }
}
