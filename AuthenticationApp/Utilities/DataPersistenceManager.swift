//
//  Utilities.swift
//  AuthenticationApp
//
//  Created by Ahmed Nafie on 28/06/2022.
//

import Foundation
import SQLite

class DataPersistenceManager {
    // MARK: - Singleton
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    private enum UserDefaultsKeys {
        static let loggedInUserID = "AAloggedInUserID"
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
    
    var loggedInUserID: Int {
        get {
            UserDefaults.standard.integer(forKey: UserDefaultsKeys.loggedInUserID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.loggedInUserID)
        }
    }
}

// MARK: - Methods
extension DataPersistenceManager {
    func setupDatabase() {
        createDatabase()
        createTable()
    }
    
    // MARK: - Create
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
    
    // MARK: - Read
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
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if email == (user [self.email]) {
                    return (user [self.password])
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func getID(forEmail email: String) -> Int? {
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if email == (user [self.email]) {
                    return (user [self.id])
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func getLoggedInUser() -> User? {
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if loggedInUserID == (user [self.id]) {
                    return User(name: (user [self.name]),
                                gender: .male,
                                email: (user [self.email]),
                                password: (user [self.password]),
                                imagePath: "")
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func getLoggedInUserImagePath() -> String? {
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if loggedInUserID == (user [self.id]) {
                    let email = (user [self.email])
                    guard
                        let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    else { return nil }
                    return directory.appendingPathComponent("\(email)+profileImage.jpg").path
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    // MARK: - Update
    func updateUserName(with name: String) {
        let userTable = usersTable.filter(self.id == loggedInUserID)
        do {
            try database.run(userTable.update(self.name <- name))
        } catch {
            print(error)
        }
    }
    
    func updateUserEmail(with email: String) {
        let userTable = usersTable.filter(self.id == loggedInUserID)
        do {
            try database.run(userTable.update(self.email <- email))
        } catch {
            print(error)
        }
    }
}

// MARK: - Private Methods
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

