//
//  Profile.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var genderLabel: UILabel!
    
    // MARK: - Properties
    var user: User?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserInfo()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped() {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
        navigationController?.viewControllers = [signUpVC!]
    }
}

//MARK: Private methods
private extension ProfileVC {
    func showUserInfo() {
        if let name = user?.name,
           let email = user?.email,
           let gender = user?.gender {
            nameLabel.text = "Name: \(name)"
            emailLabel.text = "Email: \(email)"
            genderLabel.text = "Gender: \(gender.rawValue)"
        }
    }
}
