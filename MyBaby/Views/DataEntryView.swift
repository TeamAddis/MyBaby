//
//  DataEntryView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/20.
//

import SwiftUI
import Foundation

struct DataEntryView: View {
    var disableForm: Bool {
        !didPee && !didPoop && !validWeight() && !validMilkVolume(volumeString: breastMilkTextField) && !validMilkVolume(volumeString: formulaMilkTextField)
    }
    
    @State private var keyboardIsShowing: Bool = false
    @State private var didPee: Bool = false
    @State private var didPoop: Bool = false
    
    @State private var babyWeightTextField: String = ""
    @State private var breastMilkTextField: String = ""
    @State private var formulaMilkTextField: String = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    Section("General") {
                        HStack {
                            Spacer()
                            Text("Ian is 32 days old!")
                            Spacer()
                        }
                        HStack {
                            Text("Weight: ")
                            TextField("g", text: self.$babyWeightTextField)
                                .keyboardType(.decimalPad)
                        }
                    }
                    Section("Milk") {
                        MilkTextField(milkLabel: MilkType.Breastmilk.name, milkTextField: self.$breastMilkTextField)
                        MilkTextField(milkLabel: MilkType.Formula.name, milkTextField: self.$formulaMilkTextField)
                    }
                    Section("Diaper Change") {
                        CheckmarkToggleButton(buttonLabel: "Pee", isSelected: self.$didPee)
                        CheckmarkToggleButton(buttonLabel: "Poop", isSelected: self.$didPoop)
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Save Data")
                            Spacer()
                        }
                    })
                        .disabled(disableForm)
                }
            }
            .navigationBarTitle(Text("Enter Data"))
        }
    }
    
    func validMilkVolume(volumeString: String) -> Bool {
        guard !volumeString.isEmpty else { return false }
        return CharacterSet(charactersIn: volumeString).isSubset(of: CharacterSet.decimalDigits)
    }
    
    func validWeight() -> Bool {
        guard !self.babyWeightTextField.isEmpty else { return false }
        var modifiedDecimalCharacterSet = CharacterSet.decimalDigits
        modifiedDecimalCharacterSet.insert(charactersIn: ".")
        return CharacterSet(charactersIn: self.babyWeightTextField).isSubset(of: modifiedDecimalCharacterSet)
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DataEntryView().navigationViewStyle(StackNavigationViewStyle())
    }
}
