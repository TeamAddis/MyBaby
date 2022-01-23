//
//  BabyRecordListView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import SwiftUI

struct BabyRecordListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BabyRecordListRowView: View {
    var record: BabyRecord
    
    let hours: Int
    let minutes: Int
    
    init(record: BabyRecord) {
        self.record = record
        
        let requestedDateComponents: Set<Calendar.Component> = [
            .day,
            .hour,
            .minute
        ]
        let dateTimeComponents = Calendar.current.dateComponents(requestedDateComponents, from: record.dateTime)
        hours = dateTimeComponents.hour!
        minutes = dateTimeComponents.minute!
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Time")
                Text("\(self.hours.description):\(self.minutes.description)")
            }
            VStack {
                Text("Weight")
                Text("\(record.weight.description)")
            }
            VStack {
                Text("Breast Milk")
                Text("\(record.breastMilkVolume.description)")
            }
            VStack {
                Text("Formula Milk")
                Text("\(record.formulaMilkVolume.description)")
            }
            VStack {
                Text("Did Pee")
                Text("\(record.pee.description)")
            }
            VStack {
                Text("Did Poop")
                Text("\(record.poop.description)")
            }
        }
    }
}

struct BabyRecordListView_Previews: PreviewProvider {
    static var previews: some View {
        BabyRecordListView()
    }
}

struct BabyRecordListRowView_Previews: PreviewProvider {
    static var previews: some View {
        BabyRecordListRowView(record: BabyRecord(id: nil, dateTime: Date.now, weight: 2.5, breastMilkVolume: 50, formulaMilkVolume: 30, pee: true, poop: false))
    }
}
