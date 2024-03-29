//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 16.04.2022.
//

import UIKit

final class LaunchesViewController: UIViewController {
    
    var rocketId: String?
    var rocketName: String?
    
    private let launchesService: LaunchesService
    private let viewModelMapper: ViewModelMapper
    
    private let launchesTableView = UITableView()
    
    private var launches = [LaunchViewModel]()
    
    init(launchesService: LaunchesService, viewModelMapper: ViewModelMapper) {
        self.launchesService = launchesService
        self.viewModelMapper = viewModelMapper
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(launchesTableView)
        launchesTableView.translatesAutoresizingMaskIntoConstraints = true
        launchesTableView.dataSource = self
        launchesTableView.register(LaunchCell.self, forCellReuseIdentifier: "LaunchCell")
        launchesTableView.estimatedRowHeight = UITableView.automaticDimension
        launchesTableView.rowHeight = UITableView.automaticDimension
        launchesTableView.backgroundColor = .black
        launchesTableView.allowsSelection = false
        
        guard let rocketId = rocketId else {
            return
        }
        
        launchesService.requestRocketInfo { result in
            guard case .success(let launches) = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.launches = launches
                    .filter { $0.rocket == rocketId }
                    .map(self.viewModelMapper.map(launchModel:))
                
                self.launchesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        launchesTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = rocketName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
}

extension LaunchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as? LaunchCell else {
            return UITableViewCell()
        }
        
        let viewModel = launches[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
}
