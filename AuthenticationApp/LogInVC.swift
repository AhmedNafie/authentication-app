//
//  LogInVC.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class LogInVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    // MARK: - Properties
    var user: User?
    
    // MARK: - Actions
    @IBAction func logInButtonTapped() {
        if let user = user, isValidCredentials() {
            goToProfileVC(with: user)
        }
    }
}

// MARK: - Private Methods
private extension LogInVC {
    func isValidCredentials() -> Bool {
//        guard isDataProvided() else {
//            showAlert(with: "You didn't Provide Your Data!")
//            return false
//        }
//        
//        guard emailTextField.text!.isValidEmail else {
//            showAlert(with: "Email Is Not Valid")
//            return false
//        }
//        
//        guard emailTextField.text?.trimmed.lowercased() == user?.email.lowercased() else {
//
//            showAlert(with: "Email Is Not Found!")
//            return false
//        }
//        
//        guard passwordTextField.text?.trimmed == user?.password else {
//            showAlert(with: "Wrong Password")
//            return false
//        }
//        
        return true
    }
    
    func isDataProvided() -> Bool {
        guard
            emailTextField.text!.isNotEmpty,
            passwordTextField.text!.isNotEmpty
        else {
            return false
        }
        return true
    }
    
    func goToProfileVC(with user: User) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.user = user
        navigationController?.pushViewController(profileVC, animated: true) {
            self.navigationController?.viewControllers = [profileVC]
        }
    }
}

