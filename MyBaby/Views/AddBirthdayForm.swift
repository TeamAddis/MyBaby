//
//  AddBirthdayForm.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/24.
//

import SwiftUI

struct AddBirthdayForm: View {
    @Environment(\.dismiss) var dismiss
    @State private var birthday: Date = Date()
    @Binding var showBirthday: Bool
    
    var body: some View {
        VStack {
            Text("Add Birthday")
                .padding()
            DatePicker("Birthday", selection: self.$birthday)
                .padding()
            HStack {
                Spacer()
                Button(action: {
                    self.saveBirtday()
                }, label: {
                    Text("Save")
                })
                Spacer()
            }
            .padding()
        }
    }
    
    func saveBirtday() {
        UserDefaults.standard.set(self.birthday, forKey: "babyBirthday")
        showBirthday = true
        dismiss()
    }
}

struct AddBirthdayForm_Previews: PreviewProvider {
    static var previews: some View {
        AddBirthdayForm(showBirthday: .constant(false))
    }
}
