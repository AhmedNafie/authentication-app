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
    
    // MARK: - Actions
    @IBAction func logInButtonTapped() {
        handleLogIn()
    }
}

// MARK: - Private Methods
private extension LogInVC {
    func handleLogIn() {
        DataPersistenceManager.shared.emailIDGiver(email: emailTextField.text ?? "")
        DataPersistenceManager.shared.passwordIDGiver(password: passwordTextField.text ?? "")
        
        if isValidCredentials() {
            enableIsLoggedIn()
            goToProfileVC()
        }
    }
    func isDataBelongingToSameUser() -> Bool {
        guard DataPersistenceManager.shared.emailIDGiver(email: emailTextField.text ?? "") ==
                DataPersistenceManager.shared.passwordIDGiver(password: passwordTextField.text ?? "") else {
                    showAlert(with: "Data doesnt belong to the user")
                    return false
                }
        return true
    }
    
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
            emailTextField.text?.trimmed.lowercased() == DataPersistenceManager.shared.emailGetter(id: DataPersistenceManager.shared.emailIDGiver(email: emailTextField.text ?? ""))
        else {
            showAlert(with: "Email Is Not Found!")
            return false
        }
        
        guard
            passwordTextField.text?.trimmed == DataPersistenceManager.shared.passwordGetter(id: DataPersistenceManager.shared.passwordIDGiver(password: passwordTextField.text ?? ""))
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
    
    func enableIsLoggedIn() {
        DataPersistenceManager.shared.isLoggedIn = true
    }
    
    func goToProfileVC() {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
        navigationController?.pushViewController(profileVC!, animated: true) {
            self.navigationController?.viewControllers = [profileVC!]
        }
    }
}

