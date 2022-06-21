//
//  UIViewController+showAlert.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 26/04/2022.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showAlertForEditingUserInformation(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default)
        let confirmAction = UIAlertAction.init(title: "Confirm Changes?", style: .default) {_ in
            var alertInput = ""
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                alertInput = textField.text!
             print(alertInput)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter New Data"
        }
        present(alert, animated: true)
    }
}


