//
//  String+Valid.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 23/04/2022.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        !self.trimmed.isEmpty
    }
}
