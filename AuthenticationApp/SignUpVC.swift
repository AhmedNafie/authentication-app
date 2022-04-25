//
//  ViewController.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private var nameTextFIeld: UITextField!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
    // MARK: - Actions
    @IBAction private func signUpButtonTapped() {
        if let user = validatedUser() {
            goToLogInVC()
        }
    }
    
    @IBAction private func genderSwitchTapped(genderSwitch: UISwitch) {
        genderLabel.text = genderSwitch.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
}

// MARK: - Functions
extension SignUpVC {
    private func validatedUser() -> User? {
        guard
            let name = nameTextFIeld.text?.trimmed,
            let genderRawValue = genderLabel.text?.trimmed,
            let gender = Gender.init(rawValue: genderRawValue),
            let email = emailTextField.text?.trimmed,
            let password = passwordTextField.text?.trimmed,
            let _ = confirmPasswordTextField.text?.trimmed
        else {
            print("You didn't provide your data!")
            return nil
        }
        let user = User(name: nameTextFIeld.text!.trimmed,
                        gender: gender,
                        email: email,
                        password: password)
        print(user)
        return user
    }
    
    private func checkDataFieldsEmptiness() -> Bool {
        guard
            let name = nameTextFIeld.text?.isNotEmpty,
            let genderRawValue = genderLabel.text?.isNotEmpty,
            let email = emailTextField.text?.isNotEmpty,
            let password = passwordTextField.text?.isNotEmpty,
            let _ = confirmPasswordTextField.text?.isNotEmpty
        else {
            return false
            print("You didn't provide your data!")

        }
        return true
        
    }
    private func goToLogInVC() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
    }
}
