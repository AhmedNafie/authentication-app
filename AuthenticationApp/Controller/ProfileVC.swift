//
//  Profile.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class ProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var userInformationTableView: UITableView!

    // MARK: - Properties
    var userDataArray = [UserDefaults.standard.string(forKey: "AAName"),
                         UserDefaults.standard.string(forKey: "AAEmail"),
                         UserDefaults.standard.string(forKey: "AAGender")]
    var tableFieldTexts = ["Name", "Email", "Gender"]

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage()
        self.userInformationTableView.delegate = self
        self.userInformationTableView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped() {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
        navigationController?.viewControllers = [signUpVC!]
    }
}

//MARK: Private methods
private extension ProfileVC {
    func showImage() {
        guard let data = UserDefaults.standard.data(forKey: "AAImage") else { return }
        imageView.image = UIImage(data: data)
    }
}

//MARK: TableView protocols conformance methods
extension ProfileVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell", for: indexPath)
        cell.textLabel?.text = tableFieldTexts[indexPath.row]
        cell.detailTextLabel?.text = userDataArray[indexPath.row]
        return cell
    }
}
