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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
    }
    
    @IBAction func logInButtonTapped() {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
        navigationController?.pushViewController(profileVC!, animated: true)
    }
}
