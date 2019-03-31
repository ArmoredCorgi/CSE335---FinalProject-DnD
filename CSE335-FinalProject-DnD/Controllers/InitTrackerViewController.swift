//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class InitTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets

    @IBOutlet weak var initiativeTable: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: Variables
    let player1 : Player = Player(initiative: 16, name: "Player1", className: "Paladin", maxHP: 30, ac: 14, pp: 14)
    let player2 : Player = Player(initiative: 12, name: "Player2", className: "Cleric", maxHP: 36, ac: 17, pp: 18)
    
    var charList: [Character] {
        get {
            return [player1, player2]
        }
    }
    
    // MARK: Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initiativeTable.register(CharacterTableCell.self, forCellReuseIdentifier: "charCell")
    }
    
    // MARK: TableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib (nibName: "CharacterTableCell", bundle: nil), forCellReuseIdentifier: "charCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterTableCell
        
        cell.initiativeLabel.text = String(charList[indexPath.row].initiative!)
        cell.nameLabel.text = charList[indexPath.row].name
        cell.hpLabel.text = String(charList[indexPath.row].maxHP!) + " / " + String(charList[indexPath.row].maxHP!) //TODO: Update the first string to be charList[indexPath.row].currHP!
        let currHPPercent = Float(charList[indexPath.row].currHP!) / Float(charList[indexPath.row].maxHP!)
        let currHPWidth = cell.backgroundHPBar.frame.width * CGFloat(currHPPercent)
        cell.currentHPBar.widthAnchor.constraint(equalToConstant: currHPWidth).isActive = true
        
        return cell
    }
}
