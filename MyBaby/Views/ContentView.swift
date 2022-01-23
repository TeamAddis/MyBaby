//
//  ContentView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/20.
//

import SwiftUI

struct ContentView: View {
    private enum ContentTabBarOptions {
        case enterData, summary
    }
    @State private var tabSelection = ContentTabBarOptions.enterData
    
    var body: some View {
        TabView(selection: $tabSelection) {
            SummaryView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                }
                .tag(ContentTabBarOptions.summary)
            DataEntryView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .tag(ContentTabBarOptions.enterData)
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
