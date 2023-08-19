//
//  LoginViewControllerViewModel.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation
import Combine

class LoginViewControllerViewModel: BaseViewModel {
    @Published var loginStatus: Bool = false
    
    private var apiService: NetworkService
    private var userProvider: UserProvider
    
    init(apiService: NetworkService, userProvider: UserProvider) {
        self.apiService = apiService
        self.userProvider = userProvider
    }

    func loginWith(username: String, password: String) {
        // Start Loading
        isLoading.toggle()
        
        // Validate username and password
        self.apiService.login(username: username, password: password) {[weak self] result in
            
            // Stop Loading
            self?.isLoading.toggle()
            
            switch result {
            case .success(let token):
                // API returned token
                self?.userProvider.login(username: username, token: token)
                self?.loginStatus = true
                
            case .failure(_):
                // API returned error
                self?.userProvider.logout()
                self?.loginStatus = false
            }
        }
    }
}
