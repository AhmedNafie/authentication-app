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
        static let name = "AAName"
        static let email = "AAEmail"
        static let gender = "AAGender"
        static let password = "AAPassword"
        static let imageData = "AAImageData"
        static let isLoggedIn = "AAisLoggedIn"
    }
    
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
    
    var imageData: Data {
        get {
            UserDefaults.standard.data(forKey: UserDefaultsKeys.imageData) ?? Data()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.imageData)
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
