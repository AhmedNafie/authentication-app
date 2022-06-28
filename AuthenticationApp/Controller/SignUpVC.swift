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
    
    var firstResponder: UIView?
    var isKeyboardVisible = false /// You can handle tap on view by checking if keyboard is visible.
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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

    @objc
    fileprivate func keyboardNotification(_ notification: Notification) {

        self.isKeyboardVisible.toggle()

        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

            let keyboardFrame = keyboardValue.cgRectValue


            if let textField = self.firstResponder {
                let textFieldPoints = textField.convert(textField.frame.origin, to: self.view.window)
                let textFieldRect   = textField.convert(textField.frame, to: self.view.window)

                let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + textField.frame.height, right: 0)

                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset

                // visible part of the view, where is not covered by the keyboard.
                var windowFrame = self.view.frame
                windowFrame.size.height -= keyboardFrame.height

                // if you don't see the firstResponder view in visible part, means the view is beneth the keyboard.
                if !windowFrame.contains(textFieldPoints) {
                    self.scrollView.scrollRectToVisible(textFieldRect, animated: true)
                }
            }
        }

        if notification.name == UIResponder.keyboardWillHideNotification {
            self.scrollView.contentInset = .zero
            self.scrollView.scrollIndicatorInsets = .zero
        }
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
        DataPersistenceManager.shared.name = user.name
        DataPersistenceManager.shared.gender = user.gender.rawValue
        DataPersistenceManager.shared.email = user.email
        DataPersistenceManager.shared.password = user.password
    }
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func saveImage() {
        guard let data = imageView.image?.jpegData(compressionQuality: 1) else { return }
        DataPersistenceManager.shared.image = data
    }
}

// MARK: TextField Delegate
extension SignUpVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.firstResponder = textField // We set the firstResponder variable to active textField,
        // This then will be handled in keyboardNotification()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.firstResponder = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
