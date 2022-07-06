//
//  ViewController.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 20/04/2022.
//

import UIKit

class SignUpVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataPersistenceManager.shared.setupDatabase()
        DataPersistenceManager.shared.returnUserPassword()
    }
    // MARK: - Actions
    @IBAction private func signUpButtonTapped() {
        if let user = validatedUser() {
            saveData(of: user)
            saveImage()
            goToLogInVC()
        }
    }
    
    @IBAction private func signInButtonTapped() {
        goToLogInVC()
    }
    
    @IBAction private func genderSwitchTapped(genderSwitch: UISwitch) {
        genderLabel.text = genderSwitch.isOn ? Gender.male.rawValue : Gender.female.rawValue
    }
    
    @IBAction private func changeImageButtonTapped() {
        showImagePickerController()
    }
}

// MARK: - UIImagePickerController Delegate
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods
private extension SignUpVC {
    func validatedUser() -> User? {
        guard isDataProvided() else {
            showAlert(with: "You didn't Provide Your Data!")
            return nil
        }
        
        guard emailTextField.text!.isValidEmail else {
            showAlert(with: "Email Is Not Valid")
            return nil
        }
        
        guard passwordTextField.text!.isValidPassword else {
            showAlert(with: "Invalid Password Format")
            return nil
        }
        
        guard passwordTextField.text?.trimmed == confirmPasswordTextField.text?.trimmed else {
            showAlert(with: "Passwords Doesn't Match")
            return nil
        }
        
        return User(name: nameTextField.text!.trimmed,
                    gender: .init(rawValue: genderLabel.text!)!,
                    email: emailTextField.text!.trimmed,
                    password: passwordTextField.text!.trimmed,
                    imagePath: "")
    }
    
    func isDataProvided() -> Bool {
        guard
            nameTextField.text!.isNotEmpty,
            emailTextField.text!.isNotEmpty,
            passwordTextField.text!.isNotEmpty,
            confirmPasswordTextField.text!.isNotEmpty
        else {
            return false
        }
        return true
    }
    
    func goToLogInVC() {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(logInVC!, animated: true)
    }
    
    func saveData(of user: User) {
        DataPersistenceManager.shared.insertUser(name: user.name, email: user.email, password: user.password, imagePath: user.imagePath)
        DataPersistenceManager.shared.user = user
    }
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func saveImage() {
        guard
            let data = imageView.image?.jpegData(compressionQuality: 1),
            let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        else { return }
        
        do {
            let imageURL = directory.appendingPathComponent("profileImage.jpg")
            try data.write(to: imageURL)
            DataPersistenceManager.shared.user?.imagePath = imageURL.path
        } catch {
            print(error.localizedDescription)
        }
    }
}
