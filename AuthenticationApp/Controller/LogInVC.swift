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
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Actions
    @IBAction func logInButtonTapped() {
        if isValidCredentials() {
            handleLoggingIn()
            goToProfileVC()
        }
    }
}

// MARK: - Private Methods
private extension LogInVC {
    func isValidCredentials() -> Bool {
        guard isDataProvided() else {
            showAlert(with: "You didn't Provide Your Data!")
            return false
        }
        
        guard emailTextField.text!.isValidEmail else {
            showAlert(with: "Email Is Not Valid")
            return false
        }
        
        guard
            let email = UserDefaults.standard.string(forKey: "AAEmail")?.lowercased(),
            emailTextField.text?.trimmed.lowercased() == email
        else {
            showAlert(with: "Email Is Not Found!")
            return false
        }
        
        guard
            passwordTextField.text?.trimmed == UserDefaults.standard.string(forKey: "AAPassword")
        else {
            showAlert(with: "Wrong Password")
            return false
        }
        
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
    
    func goToProfileVC() {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
        navigationController?.pushViewController(profileVC!, animated: true) {
            self.navigationController?.viewControllers = [profileVC!]
        }
    }
    
    func handleLoggingIn() {
        var isLoggedIn: Bool?
        isLoggedIn = true
        UserDefaults.standard.set(isLoggedIn, forKey: "AAlogin")
    }
}

