//
//  Utilities.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 28/06/2022.
//

import Foundation
import UIKit

class DataPersistenceManager {
    // MARK: - Singleton
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    private enum UserDefaultsKeys {
        static let user = "AAUser"
        static let isLoggedIn = "AAisLoggedIn"
    }
    
    // MARK: - Properties
    var user: User? {
        get {
            if let savedUser = UserDefaults.standard.data(forKey: UserDefaultsKeys.user) {
                let decoder = JSONDecoder()
                if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                    return loadedUser
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encodedUser = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedUser, forKey: UserDefaultsKeys.user)
            }
        }
    }
    
    var isLoggedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
}
