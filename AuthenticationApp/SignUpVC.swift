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
    
    // MARK: - private Outlets
    @IBOutlet weak var nameTextFIeld: UITextField!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak var genderSwtich: UISwitch!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: - private Actions
    @IBAction private func signUpButtonTapped() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
    }
    
    @IBAction private func genderSwtichTapped() {
        genderLabel.text = genderSwtich.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
}


