//
//  Profile.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var userInformationTableView: UITableView!

    // MARK: - Properties
    private var cellData = [
        (title: "Name", detail: DataPersistenceManager.shared.name),
        (title: "Email", detail: DataPersistenceManager.shared.email),
        (title: "Gender", detail: DataPersistenceManager.shared.gender)
    ]

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage()
        setupTableView()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped() {
        handleLogout()
        decode()
    }
}

//MARK: UITableView DataSource 
 extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCell", for: indexPath)
        cell.textLabel?.text = cellData[indexPath.row].title
        cell.detailTextLabel?.text = cellData[indexPath.row].detail
        return cell
    }
}

//MARK: UITableView Delegate
extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellTitle = cellData[indexPath.row].title
        if cellTitle != "Gender" {
            showAlertForEditingUserInformation(with: cellTitle.lowercased())
        }
    }
}

//MARK: Private methods
private extension ProfileVC {
    func showImage() {
        let imageData = DataPersistenceManager.shared.imageData
        imageView.image = UIImage(data: imageData)
    }
    
    func setupTableView() {
        userInformationTableView.dataSource = self
        userInformationTableView.delegate = self
    }
    
    func showAlertForEditingUserInformation(with title: String) {
        let alert = UIAlertController(title: "Change \(title)", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter new \(title)"
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction.init(title: "Confirm", style: .default) { _ in
            let textField = alert.textFields![0]
            let isValid = (title == "name") ? textField.text!.isNotEmpty : textField.text!.isValidEmail
            if isValid {
                let row = self.userInformationTableView.indexPathForSelectedRow!.row
                let userData = textField.text!
                self.editUserData(at: row, with: userData)
                self.updateTableView(at: row, with: userData)
            } else {
                self.showAlert(with: "\(title.capitalized) is not valid")
            }
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func editUserData(at row: Int, with userData: String) {
        if row == 0 {
            DataPersistenceManager.shared.name = userData
        } else {
            DataPersistenceManager.shared.email = userData
        }
    }
    
    func updateTableView(at row: Int, with userData: String) {
        cellData[row].detail = userData
        userInformationTableView.reloadData()
    }
    
    func handleLogout() {
        disableIsLoggedIn()
        goToSignUpVC()
    }
    
    func disableIsLoggedIn() {
        DataPersistenceManager.shared.isLoggedIn = false
    }
    
    func goToSignUpVC() {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
        navigationController?.viewControllers = [signUpVC!]
    }
    
    func decode() {
        if let savedUser = DataPersistenceManager.shared.user as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                print(loadedUser.name)
                print(loadedUser)
            }
        }
    }
}
