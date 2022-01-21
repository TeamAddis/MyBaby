//
//  BabyRecord.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/21.
//

import Foundation

enum Poop: String, CaseIterable, Identifiable {
    case none = "None"
    case small = "Small"
    case large = "Large"
    case constipaited = "Constipaited"
    
    var id: Poop {self}
    var name: String {return self.rawValue}
}

struct BabyRecord {
    
}
