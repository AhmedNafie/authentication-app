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

class SignUpVC: UIViewController {
    // MARK: - private Outlets
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak var genderSwtich: UISwitch!
    // MARK: - private Actions

    @IBAction private func signUpButtonTapped() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
    }
    
    @IBAction private func genderSwtichTapped() {
        genderLabel.text = genderSwtich.isOn ? Gender.male.rawValue : Gender.female.rawValue
}
}


