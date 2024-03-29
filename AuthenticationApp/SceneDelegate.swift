//
//  SceneDelegate.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        configureIQKeyboardManager()
        setRootVC()
        setupDatabase()
    }
}

// MARK: - Private Methods
private extension SceneDelegate {
    func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func setRootVC() {
        if DataPersistenceManager.shared.loggedInUserID != 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController (withIdentifier: "ProfileVC")
            let navigationController = UINavigationController(rootViewController: profileVC)
            window?.rootViewController = navigationController
        }
    }
    
    func setupDatabase() {
        DataPersistenceManager.shared.setupDatabase()
        DataPersistenceManager.shared.listUsers()
    }
}

