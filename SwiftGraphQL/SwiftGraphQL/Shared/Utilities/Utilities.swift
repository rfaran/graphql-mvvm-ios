//
//  Utilities.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class Utilities {
    
    /// Returns initialized LoginViewController
    static func loginViewController() -> BaseViewController {
        let viewModel = LoginViewControllerViewModel(
            apiService: ApolloClientNetworkService.shared,
            userProvider: UserProviderDefault.shared
        )
        let viewController = LoginViewController.build(viewModel:viewModel)
        return viewController
    }
    
    /// Shows alert with given title and message
    static func displayAlert(
        title: String,
        message: String,
        cancelButtonText: String = "Ok",
        cancelButtonHandler: ((UIAlertAction) -> Void)? = nil
    ) {

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelButtonText, style: .cancel, handler: cancelButtonHandler))
        
        if let viewController = UIWindow.key?.rootViewController {
            viewController.present(alert, animated: true)
        }
    }
}
