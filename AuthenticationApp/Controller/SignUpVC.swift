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
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
                    password: passwordTextField.text!.trimmed)
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
        UserDefaults.standard.set(user.name, forKey: "AAName")
        UserDefaults.standard.set(genderLabel.text, forKey: "AAGender")
        UserDefaults.standard.set(user.email, forKey: "AAEmail")
        UserDefaults.standard.set(user.password, forKey: "AAPassword")
    }
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func saveImage() {
        guard let data = imageView.image?.jpegData(compressionQuality: 1) else { return }
        UserDefaults.standard.set(data, forKey: "AAImage")
    }
    @objc func keyboardWillAppear(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
//            let bottomSpace = self.view.frame.height - (genderLabel.frame.origin.y + genderLabel.frame.height)
            self.view.frame.origin.y -= keyboardHeight - 251 + 7
        }
    }
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
}

