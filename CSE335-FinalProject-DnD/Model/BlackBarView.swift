//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class BlackBarView : UIView {
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil && backgroundColor!.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
}
