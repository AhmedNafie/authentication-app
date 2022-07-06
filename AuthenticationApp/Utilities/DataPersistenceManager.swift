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
    
    // MARK: - Private Properties
    private var database: Connection!
    private let usersTable = Table("users")
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let gender = Expression<Gender>("gender")
    private let email = Expression<String>("email")
    private let password = Expression<String>("password")
    private let imagePath = Expression<String>("imagePath")
    
    // MARK: - Properties
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
    
    func insert(_ user: User) {
        let insertUser = self.usersTable.insert(self.name <- user.name,
                                                self.email <- user.email,
                                                self.password <- user.password,
                                                self.imagePath <- user.imagePath)
        do {
            try self.database.run(insertUser)
            print("inserted user")
        } catch {
            print(error)
        }
    }
    
    func listUsers() {
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("userid: \(user[self.id]) , name \(user [self.name]), email \(user [self.email]), password \(user [self.password]),  imagePath \(user [self.imagePath])")
            }
        } catch {
            print(error)
        }
    }
    
    func getPassword(forEmail email: String) -> String? {
        var password: String?
        do {
            let users = try self.database.prepare(self.usersTable)
            let userTable = usersTable.filter(self.email == email)
            for user in users {
                if email == (user [self.email]) {
                    password = (user [self.password])
                    print([self.id])
                    print("\([self.id])")
                }
            }
        } catch {
            print(error)
        }
        print(password)
        return password
    }
    
    func getID(forEmail email: String) -> Int? {
        var userID: Int?
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if email == (user [self.email]) {
                    userID = (user [self.id])
                    print([self.id])
                    print("\([self.id])")
                }
            }
        } catch {
            print(error)
        }
        print(userID)
        return userID
    }
    
    func getID(forPassword password: String) -> Int? {
        var userID: Int?
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if password == (user [self.password]) {
                    userID = (user [self.id])
                }
            }
        } catch {
            print(error)
        }
        print(userID)
        return userID
    }
    
    func getEmail(for id: Int) -> String {
        var userEmail = ""
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if id == (user [self.id]) {
                    userEmail = (user [self.email])
                }
            }
        } catch {
            print(error)
        }
        print(userEmail)
        return userEmail
    }
    
    func getPassword(for id: Int) -> String {
        var userPassword = ""
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if id == (user [self.id]) {
                    userPassword = (user [self.password])
                }
            }
        } catch {
            print(error)
        }
        print(userPassword)
        return userPassword
    }
}

private extension DataPersistenceManager {
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
}

