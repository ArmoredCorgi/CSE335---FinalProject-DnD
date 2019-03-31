//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailTableCell: UITableViewCell {

    var character : Character!
    var delegate : DetailCellDelegate!
    
    @IBAction func detailsButtonTapped(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.segueFromDetailCell(character: character)
        }
    }
}
