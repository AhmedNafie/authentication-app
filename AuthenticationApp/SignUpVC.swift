//
//  ViewController.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class SignUpVC: UIViewController {
    //TODO: Present errors as alerts
    //TODO: add gitignore file
    
    // MARK: - Outlets
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
    // MARK: - Actions
    @IBAction private func signUpButtonTapped() {
        if let user = validatedUser() {
            goToLogInVC(with: user)
        }
    }
    
    @IBAction private func genderSwitchTapped(genderSwitch: UISwitch) {
        genderLabel.text = genderSwitch.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
}

// MARK: - Functions
extension SignUpVC {
    private func validatedUser() -> User? {
        guard isDataProvided() else {
            print("You didn't provide your data!")
            return nil
        }
        
        guard emailTextField.text!.isValidEmail else {
            print("Email Is Not Valid")
            return nil
        }
        
        guard passwordTextField.text!.isValidPassword else {
            print("Invalid Password Format")
            return nil
        }
        
        guard passwordTextField.text?.trimmed == confirmPasswordTextField.text?.trimmed else {
            print("Passwords Doesn't Match")
            return nil
        }
        
        return User(name: nameTextField.text!.trimmed,
                        gender: .init(rawValue: genderLabel.text!)!,
                        email: emailTextField.text!.trimmed,
                        password: passwordTextField.text!.trimmed)
    }
    
    private func isDataProvided() -> Bool {
        guard
            nameTextField.text!.isNotEmpty,
            emailTextField.text!.isNotEmpty,
            passwordTextField.text!.isNotEmpty,
            confirmPasswordTextField.text!.isNotEmpty
        else {
            return false
        }
        return true
    }
    
    private func goToLogInVC(with user: User) {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        logInVC.user = user
        navigationController?.pushViewController(logInVC, animated: true)
    }
}
