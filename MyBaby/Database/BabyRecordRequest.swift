//
//  BabyRecordRequest.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import Combine
import GRDB
import GRDBQuery

/// A record request can be used with the `@Query` property wrapper in order to
/// feed a view with a list of records.

struct BabyRecordRequest: Queryable {
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
            return try BabyRecord.all().fetchAll(db)
        case .dateDecending:
            return try BabyRecord.all().fetchAll(db)
        }
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
