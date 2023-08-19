//
//  RootTabBarViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

/// RootTabBarViewController is the root view controller of the application, for loggedIn users
class RootTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    // var apiService: NetworkService = MockNetworkService.shared
    var apiService: NetworkService = ApolloClientNetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = AppColors.backgroundBrand
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers = [
            getJobListViewController(),
            getSearchViewController(),
            getApplicationListViewController(),
            getProfileViewController()
        ]
    }
    
    /// Returns Active Jobs List View Controller
    func getJobListViewController() -> UINavigationController {
        let viewModel = JobsListViewControllerViewModel(
            apiService: apiService
        )

        let viewController = JobsListViewController.build(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.tabBarItem = UITabBarItem(
            title: "Jobs",
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            selectedImage: UIImage(systemName: "list.bullet.rectangle.portrait")
        )
        return navigationViewController
    }
    
    /// Returns Search View Controller
    func getSearchViewController() -> UINavigationController {
        let viewModel = SearchViewControllerViewModel(
            apiService: apiService
        )

        let viewController = SearchViewController.build(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        return navigationViewController
    }
    
    /// Returns My Applications View Controller
    func getApplicationListViewController() -> UINavigationController  {
        
        /// TODO: Replace MockNetworkService with apiService
        let viewModel = ApplicationListViewControllerViewModel(
            apiService: MockNetworkService.shared
        )

        let viewController = ApplicationListViewController.build(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.tabBarItem = UITabBarItem(
            title: "My Applications",
            image: UIImage(systemName: "briefcase"),
            selectedImage: UIImage(systemName: "briefcase")
        )
        
        return navigationViewController
    }
    
    /// Returns Profile View Controller
    func getProfileViewController() -> UINavigationController {
        let viewModel = ProfileViewControllerViewModel(
            apiService: apiService,
            userProvider: UserProviderDefault.shared
        )

        let viewController = ProfileViewController.build(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person")
        )
        
        return navigationViewController
    }
}

