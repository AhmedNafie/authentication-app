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
            goToLogInVC(With: user)
        }
    }
    
    @IBAction private func genderSwitchTapped(genderSwitch: UISwitch) {
        genderLabel.text = genderSwitch.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
}

// MARK: - Functions
extension SignUpVC {
    private func validatedUser() -> User? {
        guard checkDataFieldsEmptiness() else {
            print("You didn't provide your data!")
            return nil
        }
        
        guard emailTextField.text!.trimmed.isValidEmail else {
            print("Email Is Not Valid")
            return nil
        }
        
        guard passwordTextField.text!.trimmed.isValidPassword else {
            print("Invalid Password Format")
            return nil
        }
        
        guard passwordTextField.text == confirmPasswordTextField.text else {
            print("Passwords Doesn't Match")
            return nil
        }
        
        guard let genderRawValue = genderLabel.text?.trimmed,
              let gender = Gender.init(rawValue: genderRawValue) else {
                  return nil
              }
        
        let user = User(name: nameTextFIeld.text!.trimmed,
                        gender: gender,
                        email: emailTextField.text!.trimmed,
                        password: passwordTextField.text!.trimmed)
        return user
    }
    
    private func checkDataFieldsEmptiness() -> Bool {
        guard
            nameTextFIeld.text!.isNotEmpty,
            emailTextField.text!.isNotEmpty,
            passwordTextField.text!.isNotEmpty,
            confirmPasswordTextField.text!.isNotEmpty
        else {
            return false
        }
        return true
        
    }
    private func goToLogInVC(With user: User) {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        navigationController?.pushViewController(logInVC, animated: true)
        logInVC.user = user
    }
}
