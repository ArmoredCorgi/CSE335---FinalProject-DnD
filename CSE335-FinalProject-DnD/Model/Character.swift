//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation

class Character : NSObject {
    var initiative : Int?
    var name : String?
    var maxHP : Int?
    var currHP : Int?
    var ac : Int?
    var pp : Int?
    var conditions : [String]?
    var image : Data?
    
    init(initiative: Int?, name: String?, maxHP : Int?, ac : Int?, pp : Int?, image: Data?) {
        self.initiative = initiative
        self.name = name
        self.maxHP = maxHP
        self.currHP = maxHP
        self.ac = ac
        self.pp = pp
        self.image = image
    }
}
