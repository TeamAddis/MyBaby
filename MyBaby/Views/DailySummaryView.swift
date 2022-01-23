//
//  DailySummaryView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import SwiftUI
import GRDBQuery

struct DailySummaryView: View {
    @Query(BabyRecordRequest(ordering: .dateDecending)) private var records: [BabyRecord]
    
    var body: some View {
        VStack {
            Spacer()
            
            DailyTotalsView()
            
            List {
                ForEach(records) { record in
                    BabyRecordListRowView(record: record)
                }
            }
        }
        
    }
}

struct DailySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailySummaryView()
    }
}
