//
//  CheckmarkToggleButton.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/21.
//

import SwiftUI

struct CheckmarkToggleButton: View {
    var buttonLabel: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                self.isSelected.toggle()
            }, label: {
                HStack {
                    Text(self.buttonLabel)
                    Spacer()
                    
                    if self.isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .animation(.easeIn, value: 0.5)
                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(.primary)
                            .animation(.easeOut, value: 0.5)
                    }
                }
            })
                .buttonStyle(BorderlessButtonStyle())
        }
    }
}
