//
//  String+Trimming.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 23/04/2022.
//

import Foundation

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
