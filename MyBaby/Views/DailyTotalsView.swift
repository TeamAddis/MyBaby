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
            DailyTotalPoopView()
            Spacer()
            DailyTotalPeeView()
            Spacer()
        }
    }
}

struct DailyTotalPoopView: View {
    var body: some View {
        VStack {
            Text("Daily Total Poop:")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black)
        )
    }
}

struct DailyTotalPeeView: View {
    var body: some View {
        VStack {
            Text("Daily Total Pee:")
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
