//
//  String+IsValidPassword.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 24/04/2022.
//

import Foundation

extension String {
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[0-9]).{8,}$").evaluate(with: self.trimmed)
    }
}
