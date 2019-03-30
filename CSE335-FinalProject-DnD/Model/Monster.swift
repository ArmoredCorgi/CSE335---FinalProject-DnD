//
//  Monster.swift
//  CSE335-FinalProject-DnD
//
//  Created by Nicholas Jorgensen on 3/11/19.
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation

class Monster : NSObject {
    var initiative : Int?
    var name : String?
    var maxHP : Int?
    var currHP : Int?
    var ac : Int?
    var pp : Int?
    var conditions : [String]?
    
    init(initiative: Int?, name: String?, maxHP : Int?, ac : Int?, pp : Int?) {
        self.initiative = initiative
        self.name = name
        self.maxHP = maxHP
        self.ac = ac
        self.pp = pp
    }
}
