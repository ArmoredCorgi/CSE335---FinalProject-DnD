//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class MonsterDetailViewController: UIViewController {

    var monster : Monster!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = monster.name!
    }

}
