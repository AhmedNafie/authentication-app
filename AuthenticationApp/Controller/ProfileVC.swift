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
    @IBOutlet weak private var imageView: UIImageView!

    
    // MARK: - Properties
    var user: User?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserInfo()
        loadImage()
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
        nameLabel.text = UserDefaults.standard.string(forKey: "AAName")
        emailLabel.text = UserDefaults.standard.string(forKey: "AAEmail")
        genderLabel.text = UserDefaults.standard.string(forKey: "AAGender")
    }
    
    func loadImage() {
         guard let data = UserDefaults.standard.data(forKey: "AAImage") else { return }
         let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
         let image = UIImage(data: decoded)
        imageView.image = image
    }
}
