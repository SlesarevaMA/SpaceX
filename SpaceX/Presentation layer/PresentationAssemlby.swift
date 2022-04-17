//
//  PresentationAssemlby.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

protocol PresentationAssemlby: AnyObject {
    func rocketContainerViewController() -> RocketContainerViewController
    func rocketInfoViewController() -> RocketInfoViewController
    func launchesViewController() -> LaunchesViewController
    func settingsViewController() -> SettingsViewController
}

final class PresenationAssemblyImpl: PresentationAssemlby {
    let viewModelMapper: ViewModelMapper = ViewModelMapperImpl(userInfoStorage: CoreAssemlby.userInfoStorage)
    
    func rocketContainerViewController() -> RocketContainerViewController {
        return RocketContainerViewController(rocketInfoService: ServiceAsssemlby.rocketInfoService, presentationAssemlby: self)
    }
    
    func rocketInfoViewController() -> RocketInfoViewController {
        return RocketInfoViewController(viewModelMapper: viewModelMapper, presentationAssemlby: self)
    }
    
    func launchesViewController() -> LaunchesViewController {
        return LaunchesViewController(launchesService: ServiceAsssemlby.launchesService, viewModelMapper: viewModelMapper)
    }
    
    func settingsViewController() -> SettingsViewController {
        return SettingsViewController(userInfoStorage: CoreAssemlby.userInfoStorage)
    }
}
