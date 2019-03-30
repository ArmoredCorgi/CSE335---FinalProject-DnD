//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit
import GoogleSignIn

class TitleViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Automatically sign in the user:
        //GIDSignIn.sharedInstance().signInSilently()
    }
}
