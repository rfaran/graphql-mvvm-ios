//
//  LoginViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    private var viewModel: LoginViewControllerViewModel?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        #if DEBUG
        self.usernameTextField.text = "user1"
        self.passwordTextField.text = "Seeker1123"
        #endif
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
                
        viewModel.$isLoading.sink {[weak self] isLoading in
            self?.loadingIndicator.isHidden =  !isLoading
            self?.loginButton.isHidden = isLoading
            
        }.store(in: &cancellables)
        
        viewModel.$loginStatus.dropFirst().sink { [weak self] isLoggedIn in
            if isLoggedIn {
                self?.navigateToHome()
            } else {
                self?.showLoginErrorToUser()
            }
        }.store(in: &cancellables)
    }
    
    @IBAction func loginButtonTapped() {
        guard let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else { return }
        
        viewModel?.loginWith(username: username, password: password)
    }
}

extension LoginViewController {
    func navigateToHome() {
        self.view.window?.rootViewController = RootTabBarViewController()
    }
    
    func showLoginErrorToUser() {
        Utilities.displayAlert(title: "Login Error", message: "Incorrect Username/Password")
    }
}


// MARK: - Buildable
extension LoginViewController {
    public class func build(viewModel: LoginViewControllerViewModel) -> LoginViewController {
        let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}
