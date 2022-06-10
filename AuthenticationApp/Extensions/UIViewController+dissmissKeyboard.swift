//
//  UIViewController+dissmissKeyboard.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 10/06/2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//add the below lines to the desired VC

//// MARK: - LifeCycle Methods
//override func viewDidLoad() {
//    super.viewDidLoad()
//    self.hideKeyboardWhenTappedAround()
//}
