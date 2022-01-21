//
//  MilkRecord.swift
//  MyBaby
//
//  Created by Andrew Addis on 2022/01/21.
//

import Foundation

enum MilkType: String, Identifiable, CaseIterable {
    case Formula = "Formula"
    case Breastmilk = "Breast Milk"
    
    var name: String {return rawValue}
    var id: MilkType {self}
}

struct MilkRecord {
    
}
