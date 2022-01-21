//
//  MilkSelectionView.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/20.
//

import SwiftUI

struct Milk: Identifiable {
    var id = UUID()
    var name: String
    var isSelected: Bool = false
}

struct MilkSelectionView: View {
    @State private var milkSelection: [Milk] = [Milk(name: "Pump"),
                                               Milk(name: "Breastfeed"),
                                               Milk(name: "Formula")
    ]
    
    @Binding var showMilkSelectionView: Bool
    @Binding var milkTextField: String
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<milkSelection.count) {index in
                    HStack {
                        Button(action: {
                            milkSelection[index].isSelected.toggle()
                        }, label: {
                            HStack {
                                Text(milkSelection[index].name)
                                
                                Spacer()
                                
                                if milkSelection[index].isSelected {
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
            Button(action: {
                for milk in milkSelection {
                    self.milkTextField += "\(milk.isSelected ? "\(milk.name) " : "")"
                }
                self.showMilkSelectionView = false
            }, label: {Text("Okay")})
                .padding()
            Spacer()
        }
    }
}

struct MilkSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MilkSelectionView(showMilkSelectionView: .constant(true), milkTextField: .constant(""))
    }
}
