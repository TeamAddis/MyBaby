//
//  BabyRecord.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/21.
//

import Foundation
import GRDB

enum Poop: String, CaseIterable, Identifiable {
    case none = "None"
    case small = "Small"
    case large = "Large"
    case constipaited = "Constipaited"
    
    var id: Poop {self}
    var name: String {return self.rawValue}
}

struct BabyRecord: Identifiable, Equatable {
    var id: Int64?
    
    var dateTime: Date
    var weight: Double
    
    var breastMilkVolume: Int
    var formulaMilkVolume: Int
    
    var pee: Bool
    var poop: Bool
}

// MARK: - Persistence
/// Make BabyRecord  a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension BabyRecord: Codable, FetchableRecord, MutablePersistableRecord {
    // Define the database columns
    enum Columns {
        static let dateTime = Column(CodingKeys.dateTime)
        static let weight = Column(CodingKeys.weight)
        static let breastMilkVolume = Column(CodingKeys.breastMilkVolume)
        static let formulaMilkVolume = Column(CodingKeys.formulaMilkVolume)
        static let pee = Column(CodingKeys.pee)
        static let poop = Column(CodingKeys.poop)
    }
    
    // update the id after inserting into the DB
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
