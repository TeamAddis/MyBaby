//
//  DailySummaryView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import SwiftUI
import GRDBQuery

struct DailySummaryView: View {
    @Environment(\.appDatabase) private var appDatabase
    @Query(TodaysBabyRecords()) private var records: [BabyRecord]
    
    var body: some View {
        VStack {
            Spacer()
            
            DailyTotalsView(records: records)
            
            Spacer()
            
            BabyRecordListView(records: records)
            
            Spacer()
        }
        
    }
}

struct DailySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailySummaryView().environment(\.appDatabase, .test())
    }
}
