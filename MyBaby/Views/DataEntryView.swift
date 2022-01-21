//
//  DataEntryView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/20.
//

import SwiftUI

struct DataEntryView: View {
    enum Poop: String, CaseIterable, Identifiable {
        case none = "None"
        case small = "Small"
        case large = "Large"
        case constipaited = "Constipaited"
        
        var id: Poop {self}
        var name: String {return self.rawValue}
    }
    
    @State var showMilkSelectionView: Bool = false
    @State private var keyboardIsShowing: Bool = false
    
    @State var milkTextField: String = ""
    @State private var pee: Bool = false
    @State private var poop: Poop = .none
    @State private var hoursSleptTextField: String = ""
    @State private var ironSuppliment: Bool = false
    @State private var painkiller: Bool = false
    @State private var measureBloodPressure: Bool = false
    @State private var babyWeightTextField: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section("Baby") {
                        TextField("Milk", text: $milkTextField)
                            .onTapGesture {
                                self.showMilkSelectionView = true
                            }
                        Picker("Pee", selection: $pee) {
                            Text("O").tag(true)
                            Text("X").tag(false)
                        }
                        Picker("Poop", selection: $poop) {
                            ForEach(Poop.allCases) {value in
                                Text(value.name)
                            }
                        }
                        TextField("Weight", text: $babyWeightTextField, onEditingChanged: {editing in
                            self.keyboardIsShowing = editing
                        })
                            .keyboardType(.decimalPad)
                    }
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Save Data")
                            Spacer()
                        }
                    })
                }
                .sheet(isPresented: $showMilkSelectionView, onDismiss: {
                    
                }, content: {
                    MilkSelectionView(showMilkSelectionView: $showMilkSelectionView, milkTextField: $milkTextField)
                })
            }
            .navigationBarTitle(Text("Enter Data"))
        }
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DataEntryView().navigationViewStyle(StackNavigationViewStyle())
    }
}
