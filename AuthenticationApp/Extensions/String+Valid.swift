//
//  String+Valid.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 23/04/2022.
//

import Foundation

extension String {
    var validString: String? {
        if self.nonEmpty {
            return self.trimmed
        } else { return nil
        }
    }
}
