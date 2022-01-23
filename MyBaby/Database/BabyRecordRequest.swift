//
//  BabyRecordRequest.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import Combine
import GRDB
import GRDBQuery
import Foundation

/// A record request can be used with the `@Query` property wrapper in order to
/// feed a view with a list of records.
struct AllBabyRecords: Queryable {
    enum Ordering {
        case dateDecending
        case dateAscending
    }
    
    var ordering: Ordering
    
    static var defaultValue: [BabyRecord] {[]}
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[BabyRecord], Error> {
        ValueObservation
            .tracking(fetchValue(_:))
            .publisher(
                in: appDatabase.databaseReader,
                scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    func fetchValue(_ db: Database) throws -> [BabyRecord] {
        switch ordering {
        case .dateAscending:
            return try BabyRecord.all().orderByDateAscending().fetchAll(db)
        case .dateDecending:
            return try BabyRecord.all().orderByDateDecending().fetchAll(db)
        }
    }
}

// a query for all records of the current day
struct TodaysBabyRecords: Queryable {
    static var defaultValue: [BabyRecord] {[]}
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[BabyRecord], Error> {
        let today = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let prevDate = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        return ValueObservation
            .tracking(
                BabyRecord.all().orderByDateDecending().filter((prevDate...nextDate).contains(BabyRecord.Columns.dateTime)).fetchAll(_:)
            )
            .publisher(
                in: appDatabase.databaseReader,
                scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}


extension DerivableRequest where RowDecoder == BabyRecord {
    func orderByDateDecending() -> Self {
        order(BabyRecord.Columns.dateTime.desc)
    }
    
    func orderByDateAscending() -> Self {
        order(BabyRecord.Columns.dateTime.asc)
    }
}
