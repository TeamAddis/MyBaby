//
//  HideKeyboard+View.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/26.
//

import SwiftUI
import UIKit

class KeyboardMode: ObservableObject {
    @Published var keyboardIsShowing = false
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
