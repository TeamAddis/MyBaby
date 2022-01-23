//
//  AppDatabase.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/22.
//

import Combine
import Foundation
import GRDB

/// AppDatabase lets the application access the database.
///
/// It applies the pratices recommended at
/// <https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md>
struct AppDatabase {
    /// Creates an `AppDatabase`, and make sure the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    /// Provides access to the database.
    ///
    /// Application can use a `DatabasePool`, while SwiftUI previews and tests
    /// can use a fast in-memory `DatabaseQueue`.
    ///
    /// See <https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections>
    private let dbWriter: DatabaseWriter
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See <https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md>
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("createBabyRecord") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.create(table: "babyRecord") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("dateTime", .datetime).notNull()
                t.column("weight", .double)
                t.column("breastMilkVolume", .integer)
                t.column("formulaMilkVolume", .integer)
                t.column("pee", .boolean)
                t.column("poop", .boolean)
            }
        }
        
        // Migrations for future application versions will be inserted here:
        // migrator.registerMigration(...) { db in
        //     ...
        // }
        
        return migrator
    }
}

// MARK: - Database Access: Writes

extension AppDatabase {
    func saveBabyRecord(_ babyRecord: inout BabyRecord) throws {
        try dbWriter.write {db in
            try babyRecord.save(db)
        }
    }
    
    func deleteAll() throws {
        try dbWriter.write {db in
            _ = try BabyRecord.deleteAll(db)
        }
    }
    
    static let uiTestRecords = [
        BabyRecord(id: nil, dateTime: Date.now, weight: 0, breastMilkVolume: 80, formulaMilkVolume: 0, pee: true, poop: false),
        BabyRecord(id: nil, dateTime: Date.now, weight: 5, breastMilkVolume: 40, formulaMilkVolume: 40, pee: true, poop: true),
        BabyRecord(id: nil, dateTime: Date.now, weight: 1, breastMilkVolume: 0, formulaMilkVolume: 0, pee: false, poop: false),
        BabyRecord(id: nil, dateTime: Date.now, weight: 0, breastMilkVolume: 80, formulaMilkVolume: 0, pee: false, poop: false),
        BabyRecord(id: nil, dateTime: Date.now, weight: 1.5, breastMilkVolume: 0, formulaMilkVolume: 0, pee: false, poop: false),
        BabyRecord(id: nil, dateTime: Date.now, weight: 0, breastMilkVolume: 60, formulaMilkVolume: 20, pee: false, poop: false),
        BabyRecord(id: nil, dateTime: Date.now, weight: 3.5, breastMilkVolume: 0, formulaMilkVolume: 0, pee: false, poop: false),
    ]
    
    func createRecordsForUITest() throws {
        try dbWriter.write { db in
            try AppDatabase.uiTestRecords.forEach { record in
                _ = try record.inserted(db)
            }
        }
    }
}

// MARK: - Database Access: Reads
// This demo app does not provide any specific reading method, and instead
// gives an unrestricted read-only access to the rest of the application.
// In your app, you are free to choose another path, and define focused
// reading methods.
extension AppDatabase {
    /// Provides a read-only access to the database
    var databaseReader: DatabaseReader {
        dbWriter
    }
}
