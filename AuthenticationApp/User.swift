//
//  User.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 25/04/2022.
//

import Foundation

struct User {
    let name: String
    let gender: Gender
    let email: String
    let password: String
}

enum Gender: String {
    case male = "Male"
    case female = "Female"
}
