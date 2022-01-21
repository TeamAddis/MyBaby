//
//  ContentView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DataEntryView()
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
