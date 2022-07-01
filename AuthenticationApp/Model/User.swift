//
//  User.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 25/04/2022.
//

import Foundation

struct User: Codable {
    var name: String
    var gender: Gender
    var email: String
    var password: String
    var imagePath: String
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
}
