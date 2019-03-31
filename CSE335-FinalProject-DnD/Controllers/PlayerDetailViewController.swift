//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    var player : Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = player.name!
    }

}
