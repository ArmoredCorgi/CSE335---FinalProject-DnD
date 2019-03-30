//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class InitTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets

    @IBOutlet weak var initiativeTable: UITableView!

    // MARK: Variables
    let player1 : Player = Player(initiative: 16, name: "Player1", className: "Paladin", maxHP: 30, ac: 14, pp: 14)
    let player2 : Player = Player(initiative: 12, name: "Player2", className: "Cleric", maxHP: 36, ac: 17, pp: 18)
    
    var charList: [Player] {
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
        let cell = initiativeTable.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterTableCell
        
        cell.initiative = charList[indexPath.row].initiative
        cell.name = charList[indexPath.row].name
        cell.maxHP = charList[indexPath.row].maxHP
        cell.currHP = charList[indexPath.row].maxHP //TODO: Update this so it sets the cell's current hp to whatever the character's current health is
        
        return cell
    }
}
