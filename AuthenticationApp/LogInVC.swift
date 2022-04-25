//
//  LogInVC.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class LogInVC: UIViewController {
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
