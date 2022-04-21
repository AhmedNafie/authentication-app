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
    let name: String?
    let gender: Gender?
    let email: String?
    let password: String?
}

class SignUpVC: UIViewController {
    
    // MARK: - private Outlets
    @IBOutlet weak private var nameTextFIeld: UITextField!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var genderSwtich: UISwitch!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
    // MARK: - private Actions
    @IBAction private func signUpButtonTapped() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
        printUserData()
    }
    
    @IBAction private func genderSwtichTapped() {
        genderLabel.text = genderSwtich.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
    // MARK: - private functions
    private func printUserData() {
        let user = User(name: nameTextFIeld.text,
                        gender: Gender.init(rawValue: genderLabel.text ?? "nil"),
                        email: emailTextField.text,
                        password: passwordTextField.text)
        print(confirmPasswordTextField.text)
        print(user)
    }
}


