//
//  DailyTotalsView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import SwiftUI

struct DailyTotalsView: View {
    var records: [BabyRecord]
    
    var body: some View {
        HStack {
            Spacer()
            HoursSinceLastFeedingView(records: records)
            Spacer()
            DailyTotalPoopView(records: records)
            Spacer()
            DailyTotalPeeView(records: records)
            Spacer()
        }
    }
}

struct HoursSinceLastFeedingView: View {
    var records: [BabyRecord]
    var hoursPast: Int = 24
    
    init(records: [BabyRecord]) {
        self.records = records
        
        for record in self.records {
            if record.formulaMilkVolume > 0 || record.breastMilkVolume > 0 {
                let ti = Int(Date().timeIntervalSince(record.dateTime))
                self.hoursPast = (ti / 3600)
                break
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Hours Since Last Feeding")
            Text("\(hoursPast.description)")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black)
        )
    }
}

struct DailyTotalPoopView: View {
    var records: [BabyRecord]
    var totalPoop: Int {
        var count = 0
        for record in records {
            if record.poop {
                count += 1
            }
        }
        return count
    }
    
    var body: some View {
        VStack {
            Text("Daily Total Poop")
            Text("\(totalPoop.description)")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black)
        )
    }
}

struct DailyTotalPeeView: View {
    var records: [BabyRecord]
    var totalPee: Int {
        var count = 0
        for record in records {
            if record.pee {
                count += 1
            }
        }
        return count
    }
    
    var body: some View {
        VStack {
            Text("Daily Total Pee")
            Text("\(totalPee.description)")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black)
        )
    }
}

struct DailyTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTotalsView(records: [])
    }
}
