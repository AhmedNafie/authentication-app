//
//  UIv.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 26/04/2022.
//

import UIKit

func showAlert(_ message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let action = UIAlertAction.init(title: "Ok", style: .default)
    alert.addAction(action)
    alert.present(alert, animated: true, completion: nil)
}

