//
//  String+FullyValidPassword.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 24/04/2022.
//

import Foundation

extension String {
    var FullyValidPassword: String? {
        if self.isValidPassword && self.isEmpty {
            return self.trimmed
        }
        return nil
    }
}
