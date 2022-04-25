//
//  String+FullyValidForEmail.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 24/04/2022.
//

import Foundation

extension String {
    var fullyValidForEmail: String? {
        if self.isValidEmail && self.isEmpty {
            return self.trimmed
        }
        return nil
    }
}
