//
//  ViewController.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct User {
    let name: String
    let gender: Gender
    let email: String
    let password: String
}

class SignUpVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private var nameTextFIeld: UITextField!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
    // MARK: - Actions
    @IBAction private func signUpButtonTapped() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
        printUserData()
    }
    
    @IBAction private func genderSwitchTapped(genderSwitch: UISwitch) {
        genderLabel.text = genderSwitch.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
}

// MARK: - Functions
extension SignUpVC {
    private func printUserData() {
        guard let name = nameTextFIeld.text,
              let genderRawValue = genderLabel.text,
              let gender = Gender.init(rawValue: genderRawValue),
              let email = emailTextField.text,
              let password = passwordTextField.text
        else {
            print("You didn't provide your data!")
            return
        }
        let user = User(name: name,
                        gender: gender,
                        email: email,
                        password: password)
        print(confirmPasswordTextField.text)
        print(user)
    }
}
