//
//  String+IsValidMail.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 24/04/2022.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self.trimmed)
    }
}
