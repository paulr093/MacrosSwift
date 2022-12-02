//
//  UserMacroStore.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/5/22.
//

import Foundation
import SQLite

class UserDataStore {
    static let DIR_TASK_DB = "UserData"
    static let STORE_NAME = "userdata.sqlite3"
    
    private let userData = Table("userdata")
    
    private let id = Expression<Int64>("id")
    private let calThreshold = Expression<Int>("calThreshold")
    private let proteinThreshold = Expression<Int>("proteinThreshold")
    private let carbsThreshold = Expression<Int>("carbsThreshold")
    private let fatThreshold = Expression<Int>("fatThreshold")
    
    static let shared = UserDataStore()
    
    private var db: Connection? = nil
    
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)
            
            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
                let id = insert(id: 0, calThreshold: 0, proteinThreshold: 0, carbsThreshold: 0, fatThreshold: 0)
                if id != nil {
                    print("Base user data inserted...")
                } else {
                    print("Error inserting base user data...")
                }
                
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }
    
    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(userData.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(calThreshold)
                table.column(proteinThreshold)
                table.column(carbsThreshold)
                table.column(fatThreshold)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }
    
    func insert(id: Int64, calThreshold: Int, proteinThreshold: Int, carbsThreshold: Int, fatThreshold: Int) -> Int64? {
        guard let database = db else { return nil }
        
        let insert = userData.insert(self.calThreshold <- calThreshold,
                                     self.proteinThreshold <- proteinThreshold,
                                     self.carbsThreshold <- carbsThreshold,
                                     self.fatThreshold <- fatThreshold)
        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserData() -> [User] {
        var userData: [User] = []
        guard let database = db else { return [] }
        
        do {
            for item in try database.prepare(self.userData) {
                userData.append(User(id: item[id], calThreshold: item[calThreshold], proteinThreshold: item[proteinThreshold], carbsThreshold: item[carbsThreshold], fatThreshold: item[fatThreshold]))
            }
        } catch {
            print(error)
        }
        return userData
    }
    
    func update(id: Int64, calThreshold: Int, proteinThreshold: Int, carbsThreshold: Int, fatThreshold: Int) -> Bool {
        guard let database = db else { return false }
        
        let data = userData.filter(self.id == id)
        do {
            let update = data.update([
                self.calThreshold <- calThreshold,
                self.proteinThreshold <- proteinThreshold,
                self.carbsThreshold <- carbsThreshold,
                self.fatThreshold <- fatThreshold
            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
}
