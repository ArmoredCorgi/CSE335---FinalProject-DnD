//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation
import UIKit

class CharacterTableCell : UITableViewCell {
    
    @IBOutlet weak var currHPWidth: NSLayoutConstraint!
    @IBOutlet weak var charImage: UIImageView!
    
    // MARK: IBOutlets
    @IBOutlet weak var initiativeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var backgroundHPBar: UIView!
    @IBOutlet weak var currentHPBar: UIView!
    
}
