//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    
    var settingsList : [String] = ["About", "Find a Gaming Store"]
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 24)!]
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell")!
        
        cell.textLabel?.text = settingsList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settingsList[indexPath.row]
        
        switch(setting) {
        case "About":
            performSegue(withIdentifier: "segueToAbout", sender: self)
            break
        case "Find a Gaming Store":
            performSegue(withIdentifier: "segueToStoreSearch", sender: self)
            break
        default:
            print("ERROR: Invalid selection")
            break
        }
    }
}
