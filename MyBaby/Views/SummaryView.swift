//
//  SummaryView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import SwiftUI

struct SummaryView: View {
    private enum SegmentedControlViews {
        case dailySummary, weeklySummary
    }
    
    @State private var selectedView = SegmentedControlViews.dailySummary
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: self.$selectedView) {
                    Text("Daily").tag(SegmentedControlViews.dailySummary)
                    Text("Weekly").tag(SegmentedControlViews.weeklySummary)
                }
                .pickerStyle(.segmented)
                .padding()
                Spacer()
                
                switch selectedView {
                case .dailySummary:
                    DailySummaryView()
                        .navigationBarTitle(Text("Daily Summary"))
                case .weeklySummary:
                    Text("TODO")
                        .navigationBarTitle(Text("Weekly Summary"))
                }
            }
        }
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
