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
    var charList: [Character] {
        get {
            return [player1, player2]
        }
    }
    var selectedChar : Character!
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initiativeTable.register(CharacterTableCell.self, forCellReuseIdentifier: "charCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Initiative Tracker"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 24)!]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PlayerDetailViewController {
            destinationVC.player = selectedChar as? Player
        }
        else if let destinationVC = segue.destination as? MonsterDetailViewController {
            destinationVC.monster = selectedChar as? Monster
        }
    }
    
    // MARK: TableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib (nibName: "CharacterTableCell", bundle: nil), forCellReuseIdentifier: "charCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterTableCell
        
        //cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.initiativeLabel.text = String(charList[indexPath.row].initiative!)
        cell.nameLabel.text = charList[indexPath.row].name
        cell.hpLabel.text = String(charList[indexPath.row].currHP!) + " / " + String(charList[indexPath.row].maxHP!)
        let currHPPercent = Float(charList[indexPath.row].currHP!) / Float(charList[indexPath.row].maxHP!)
        let widthOffset : CGFloat = 12.5 //Offsetting background width (the widthConstraint is setting the width of the hp bar 12.5 pts wider than it should be)
        let bgWidth = cell.backgroundHPBar.frame.width - widthOffset
        let currHPWidth = bgWidth * CGFloat(currHPPercent)
        let widthConstraint = NSLayoutConstraint(item: cell.currentHPBar,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: currHPWidth)

        cell.currentHPBar.addConstraint(widthConstraint)
        cell.updateConstraints()
        return cell
    }
    
    // MARK: TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = charList[indexPath.row]
        
        if character is Player {
            selectedChar = character
            performSegue(withIdentifier: "segueToPlayerDetail", sender: self)
        }
        else if character is Monster {
            selectedChar = character
            performSegue(withIdentifier: "segueToMonsterDetail", sender: self)
        }
    }
}
