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
    enum UserDefaultsKeys {
        static let name = "AAName"
        static let email = "AAEmail"
        static let gender = "AAGender"
        static let password = "AAPassword"
        static let image = "AAImage"
        static let login = "AAlogin"
    }
    
    private init() {}
    
    static let shared = DataPersistenceManager()
    
    // MARK: - Properties
    var name: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.name) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.name)
        }
    }
    
    var email: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.email) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.email)
        }
    }
    
    var gender: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.gender) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.gender)
        }
    }
    
    var password: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKeys.password) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.password)
        }
    }
    
    var image: Data {
        get {
            UserDefaults.standard.data(forKey: UserDefaultsKeys.image) ?? Data()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.image)
        }
    }
    
    var login: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.login)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.login)
        }
    }
}
