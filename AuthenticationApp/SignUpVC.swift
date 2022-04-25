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

    //TODO: fix the spaces problem show mostafa the link  https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    
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
            let name = nameTextFIeld.text?.validString,
            let genderRawValue = genderLabel.text?.validString,
            let gender = Gender.init(rawValue: genderRawValue),
            let email = emailTextField.text?.fullyValidForEmail,
            let password = passwordTextField.text?.FullyValidPassword,
            let _ = confirmPasswordTextField.text?.FullyValidPassword
        else {
            print("You didn't provide your data!")
            return nil
        }
        let user = User(name: name,
                        gender: gender,
                        email: email,
                        password: password)
        print(user)
        return user
    }
    
    private func goToLogInVC() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
    }
}
