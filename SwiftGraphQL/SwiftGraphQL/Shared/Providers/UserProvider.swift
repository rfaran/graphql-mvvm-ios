//
//  UserProvider.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

/// UserProvider, that defines the contract for user related actions, e.g. login, logout etc.
protocol UserProvider {
    func login(username: String, token: String)
    func logout()
    func username() -> String
}

/// Default implementation for UserProvider protocol
final class UserProviderDefault: UserProvider {
    
    static let shared = UserProviderDefault()
    private init() {}

    /// Handles what should happen when user logs in
    func login(username: String, token: String) {
        AppData.username = username
        AppData.isUserLoggedIn = true
        AppData.userAccessToken = token
    }
    
    /// Handles what should happen when user logs out
    func logout() {
        AppData.isUserLoggedIn = false
        AppData.username = ""
        AppData.userAccessToken = nil
    }
    
    func username() -> String {
        AppData.username
    }

}
