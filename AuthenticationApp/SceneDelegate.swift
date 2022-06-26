//
//  SceneDelegate.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if UserDefaults.standard.bool(forKey: "AAlogin") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController (withIdentifier: "ProfileVC")
            let navigationController = UINavigationController(rootViewController: profileVC)
            
            window?.rootViewController = navigationController
        }
    }
    
}

