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
    
    @Environment(\.appDatabase) private var appDatabase
    @StateObject var keyboardMode = KeyboardMode()
    
    @State private var showBirthDay: Bool = false
    @State private var didPee: Bool = false
    @State private var didPoop: Bool = false
    @State private var showBirthdayForm: Bool = false
    
    @State private var babyWeightTextField: String = ""
    @State private var breastMilkTextField: String = ""
    @State private var formulaMilkTextField: String = ""
    
    @State private var dateTime: Date = Date()
    @State private var babyBirthday: Date = Date()
    
    @State private var daysOld: Int = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    Section("General") {
                        HStack {
                            Spacer()
                            if showBirthDay {
                                Text("Ian is \(self.daysOld) days old!")
                            } else {
                                Button(action: {
                                    self.showBirthdayForm = true
                                }, label: {
                                    Text("Add Birthday")
                                })
                            }
                            Spacer()
                        }
                        DatePicker("Date & Time: ", selection: self.$dateTime)
                        HStack {
                            Text("Weight: ")
                            TextField("g", text: self.$babyWeightTextField, onEditingChanged: { editing in
                                self.keyboardMode.keyboardIsShowing = editing
                            })
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
                        saveButtonPressed()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Save Data")
                            Spacer()
                        }
                    })
                        .disabled(disableForm)
                }
                .formSheet(isPresented: self.$showBirthdayForm, content: {
                    AddBirthdayForm(showBirthday: self.$showBirthDay)
                        .onDisappear(perform: {
                            self.loadBabyBirthday()
                        })
                        .frame(width: geometry.size.width / 2, height: 200, alignment: .center)
                })
            }
            .navigationBarTitle(Text("Enter Data"))
        }
        .environmentObject(keyboardMode)
        .onAppear() {
            self.dateTime = Date()
            loadBabyBirthday()
        }
        .onTapGesture {
            if self.keyboardMode.keyboardIsShowing {
                hideKeyboard()
            }
        }
    }
    
    func loadBabyBirthday() {
        if (UserDefaults.standard.object(forKey: "babyBirthday") != nil) {
            self.babyBirthday = UserDefaults.standard.object(forKey: "babyBirthday") as! Date
            self.daysOld = self.calcAge()
            self.showBirthDay = true
        }
    }
    
    // Calculate the age of the baby.
    // Return the age in days.
    func calcAge() -> Int {
        Calendar.current.dateComponents([.day], from: self.babyBirthday, to: Date()).day ?? 0
    }
    
    func cleanForm() {
        self.didPoop = false
        self.didPee = false
        self.dateTime = Date.now
        self.breastMilkTextField = ""
        self.formulaMilkTextField = ""
        self.babyWeightTextField = ""
    }
    
    func makeRecordFromForm() -> BabyRecord {
        let breastMilkVolume = Int(self.breastMilkTextField) ?? 0
        let formulaMilkVolume = Int(self.formulaMilkTextField) ?? 0
        let weight = Double(self.babyWeightTextField) ?? 0
        let pee = self.didPee
        let poop = self.didPoop
        
        return BabyRecord(id: nil, dateTime: self.dateTime, weight: weight, breastMilkVolume: breastMilkVolume, formulaMilkVolume: formulaMilkVolume, pee: pee, poop: poop)
    }
    
    func saveButtonPressed() {
        do {
            var record = makeRecordFromForm()
            try appDatabase.saveBabyRecord(&record)
            
        } catch {
            let errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
            debugPrint(errorAlertTitle)
        }
        
        cleanForm()
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
