//
//  MilkTextField.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/21.
//

import SwiftUI

struct MilkTextField: View {
    var milkLabel: String
    @State private var isSelected: Bool = false
    @Binding var milkTextField: String
    
    @EnvironmentObject var keyboardMode: KeyboardMode
    
    var body: some View {
        VStack {
            CheckmarkToggleButton(buttonLabel: self.milkLabel, isSelected: self.$isSelected)
            if self.isSelected {
                HStack {
                    Text("Volume: ")
                    TextField("ml", text: $milkTextField, onEditingChanged: { editing in
                        self.keyboardMode.keyboardIsShowing = editing
                    })
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}

struct MilkTextField_Previews: PreviewProvider {
    static var previews: some View {
        MilkTextField(milkLabel: "Breast Milk", milkTextField: .constant(""))
    }
}
