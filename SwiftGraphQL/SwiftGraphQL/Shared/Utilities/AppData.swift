//
//  AppData.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import Foundation

/// AppData, that defines the different types of data that can be stored in UserDefaults or Keychain
struct AppData {
    /// This property is to check if user is logged in or not
    @UserDefault("is_user_logged_in", defaultValue: false)
    static var isUserLoggedIn: Bool
    
    /// This property is for setting and getting username
    @UserDefault("username", defaultValue: "")
    static var username: String
    
    /// This property is used to store user access token, e.g. JWT token in Keychain
    @Keychain(key: "user_access_token", account: AppData.username, defaultValue: nil)
    static var userAccessToken: String?
}

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults

    init(_ key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: T {
        get {
            let value = userDefaults.object(forKey: key) as? T ?? defaultValue
            return value
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct Keychain {
    private let key: String
    private let account: String
    private let defaultValue: String?

    init(key: String, account: String, defaultValue: String?) {
        self.key = key
        self.account = account
        self.defaultValue = defaultValue
    }

    var wrappedValue: String? {
        get {
            if let data = KeychainHelper.standard.read(service: key, account: account),
               let accessToken = String(data: data, encoding: .utf8) {
                return accessToken
            }
            return defaultValue
        }
        set {
            if let newValue = newValue{
                KeychainHelper.standard.save(Data(newValue.utf8), service: key, account: account)
            } else {
                KeychainHelper.standard.delete(service: key, account: account)
            }
        }
    }
}
