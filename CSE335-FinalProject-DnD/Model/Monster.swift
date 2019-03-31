//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation

class Monster : Character {
    var cr : Float?
    
    init(initiative: Int?, name: String?, maxHP: Int?, ac: Int?, pp: Int?, cr: Float?) {
        super.init(initiative: initiative, name: name, maxHP: maxHP, ac: ac, pp: pp)
        self.cr = cr
    }
}
