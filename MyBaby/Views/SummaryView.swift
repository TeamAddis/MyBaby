//
//  SummaryView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/23.
//

import SwiftUI

struct SummaryView: View {
    
    var body: some View {
        NavigationView {
            
            DailySummaryView()
                .navigationBarTitle(Text("Daily Summary"))
        }
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
