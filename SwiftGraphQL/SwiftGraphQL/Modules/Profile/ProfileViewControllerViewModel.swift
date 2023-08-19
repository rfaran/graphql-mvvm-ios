//
//  ProfileViewControllerViewModel.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

class ProfileViewControllerViewModel: BaseViewModel {
    @Published var usernameText: String = ""

    private let apiService: NetworkService
    private var userProvider: UserProvider

    init(apiService: NetworkService, userProvider: UserProvider) {
        self.apiService = apiService
        self.userProvider = userProvider
        
        self.usernameText = "Welcome, \(userProvider.username())"
    }
    
    func logout() {
        self.userProvider.logout()
    }
}
