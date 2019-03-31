//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class DatabaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Database"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 24)!]
    }
}
