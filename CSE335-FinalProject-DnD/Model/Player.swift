//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation

class Player : Character {
    var className : String?
    
    init(initiative: Int?, name: String?, className : String?, maxHP : Int?, ac : Int?, pp : Int?, image: Data?) {
        super.init(initiative: initiative, name: name, maxHP: maxHP, ac: ac, pp: ac, image: image)
        self.className = className
    }
}
