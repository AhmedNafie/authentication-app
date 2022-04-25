//
//  String+Valid.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 23/04/2022.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        if !self.trimmed.isEmpty {
            return true
        }
        return false
    }
}
