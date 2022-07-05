//
//  Utilities.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 28/06/2022.
//

import UIKit
import SQLite

class DataPersistenceManager {
    // MARK: - Singleton
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    private enum UserDefaultsKeys {
        static let user = "AAUser"
        static let isLoggedIn = "AAisLoggedIn"
    }
    
    // MARK: - Properties
    var database: Connection!
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let gender = Expression<Gender>("gender")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let imagePath = Expression<String>("imagePath")

    var user: User? {
        get {
            if let savedUser = UserDefaults.standard.data(forKey: UserDefaultsKeys.user) {
                let decoder = JSONDecoder()
                if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                    return loadedUser
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encodedUser = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedUser, forKey: UserDefaultsKeys.user)
            }
        }
    }
    
    var isLoggedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
}

// MARK: - Methods
 extension DataPersistenceManager {
    func setupDatabase() {
      createDatabase()
        createTable()
    }
    
    func createDatabase() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            DataPersistenceManager.shared.database = database
            print("ask mostafaa ")

        } catch {
            print(error)
        }
    }
    
    func createTable() {
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
// gender
            table.column(self.email, unique: true)
            table.column(self.password)
            table.column(self.imagePath)
            print("created table #77")
        }
        do {
            try self.database.run(createTable)
            print("created table")
        } catch {
            print(error)
        }
    }
    
     func insertUser(name: String, email: String, password: String, imagePath: String) {
        let insertUser = self.usersTable.insert(self.name <- name, self.email <- email, self.password <- password,self.imagePath <- imagePath)
        do {
            try self.database.run(insertUser)
            print("inserted user")
        } catch {
            print(error)
        }
    }
     
     func listUsers() -> String{
         var password = ""
         do {
             let users = try self.database.prepare(self.usersTable)
             print(" ehlloo  \(users)")
             for user in users {
                 print("userid: \(user[self.id]) , name \(user [self.name]), email \(user [self.email]), password \(user [self.password]),  imagePath \(user [self.imagePath])")
                 password = (user [self.password])
                 print(password)
             }
         } catch {
             print(error)
         }
        return password
     }
}
