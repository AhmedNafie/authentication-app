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
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
    }
    
    // MARK: - Actions
    @IBAction func logInButtonTapped() {
        if let user = user,
           isLogINDataApproved() {
            goToProfileVC(with: user)
        }
    }
}

// MARK: - Private Methods
extension LogInVC {
    private func isLogINDataApproved() -> Bool {
        guard isDataProvided() else {
            showAlert("You didn't Provide Your Data!")
            return false
        }
        
        guard emailTextField.text!.isValidEmail else {
            showAlert("Email Is Not Valid")
            return false
        }
        
        guard emailTextField.text?.trimmed == user?.email else {
            showAlert("Email Is Not Found!")
            return false
        }
        
        guard passwordTextField.text?.trimmed == user?.password else {
            showAlert("Wrong Password")
            return false
        }
        
        return true
    }
    
    private func isDataProvided() -> Bool {
        guard
            emailTextField.text!.isNotEmpty,
            passwordTextField.text!.isNotEmpty
        else {
            return false
        }
        return true
    }
    
    private func goToProfileVC(with user: User) {
        let ProfileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        ProfileVC.user = user
        navigationController?.pushViewController(ProfileVC, animated: true)
    }
}

