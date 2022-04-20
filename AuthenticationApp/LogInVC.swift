//
//  LogInVC.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class LogInVc: UIViewController {
    
    @IBAction func logInButtonTapped() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let upComingVC = storyBoard.instantiateViewController(withIdentifier: "ProfileVC")
        navigationController?.pushViewController(upComingVC, animated: true)
    }
}
