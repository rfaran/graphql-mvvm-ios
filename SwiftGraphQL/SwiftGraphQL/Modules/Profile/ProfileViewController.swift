//
//  ProfileViewController.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    
    private var viewModel: ProfileViewControllerViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    func setupViews() {
        self.title = "Profile"
        
        /// Add logout button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    }
    
    func bind() {
        viewModel?.$usernameText
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.usernameLabel)
            .store(in: &cancellables)
    }
    
    @objc func logoutTapped() {
        viewModel?.logout()
        let loginViewController = Utilities.loginViewController()
        self.view.window?.rootViewController = loginViewController
    }
    
    @IBAction func changePasswordButtonTapped() {
    }
    
    @IBAction func updateProfileButtonTapped() {
    }
}

// MARK: - Buildable
extension ProfileViewController {
    public class func build(viewModel: ProfileViewControllerViewModel) -> ProfileViewController {
        let controller = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}

