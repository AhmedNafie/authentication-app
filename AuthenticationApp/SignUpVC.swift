//
//  ViewController.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class SignUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("signup vc")
    }
    
    @IBAction func signUpButtonTapped() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let upComingVC = storyBoard.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(upComingVC, animated: true)
    }
}

