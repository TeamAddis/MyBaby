//
//  ContentView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/20.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            SummaryView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                }
                .tag(0)
            DataEntryView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .tag(1)
        }
        // Force the Navigation View to use the stack navigation view style.
        // This is default on iPhone but not on iPad. This will create a uniform
        // Between the devices.
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
