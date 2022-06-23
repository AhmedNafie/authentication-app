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
        (title: "Name", detail: UserDefaults.standard.string(forKey: "AAName")),
        (title: "Email", detail: UserDefaults.standard.string(forKey: "AAEmail")),
        (title: "Gender", detail: UserDefaults.standard.string(forKey: "AAGender"))
    ]

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage()
        setupTableView()
        createTableViewChangersObservers()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped() {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
        navigationController?.viewControllers = [signUpVC!]
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
        let index = userInformationTableView.indexPathForSelectedRow
        // wanna remove the number
        if index != [0,2] {
            showAlertForEditingUserInformation(with: "Change \(cellData[indexPath.row].title) ?" )
        }
    }
}

//MARK: Private methods
private extension ProfileVC {
    func showImage() {
        guard let data = UserDefaults.standard.data(forKey: "AAImage") else { return }
        imageView.image = UIImage(data: data)
    }
    
    func setupTableView() {
        userInformationTableView.dataSource = self
        userInformationTableView.delegate = self
    }
    
    func createTableViewChangersObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(editUserData(notification:)), name: .sendUserData, object: nil)
    }
    
    @objc func editUserData(notification: Notification) {
        if let userData = notification.userInfo?["userData"] as? String {
            let index = userInformationTableView.indexPathForSelectedRow
            // wanna remove the numbers
            if index == [0,0]  {
                UserDefaults.standard.set(userData, forKey: "AAName")
                cellData[0].detail = UserDefaults.standard.string(forKey: "AAName")
                print(cellData[0].detail!)
                self.userInformationTableView.reloadData()
            } else {
                UserDefaults.standard.set(userData, forKey: "AAEmail")
                cellData[1].detail = UserDefaults.standard.string(forKey: "AAEmail")
                print(cellData[1].detail!)
                self.userInformationTableView.reloadData()
            }
        }
    }
}
