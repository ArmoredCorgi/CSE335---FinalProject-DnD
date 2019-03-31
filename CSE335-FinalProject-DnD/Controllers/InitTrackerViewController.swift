//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

struct charStruct {
    var isOpened : Bool
    var charInfo : Character
}

protocol DetailCellDelegate {
    func segueFromDetailCell (character : Character)
}

class InitTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailCellDelegate {
    
    // MARK: IBOutlets

    @IBOutlet weak var initiativeTable: UITableView!
    
    // MARK: Variables
    let player1 : Player = Player(initiative: 16, name: "Player1", className: "Paladin", maxHP: 30, ac: 14, pp: 14)
    let player2 : Player = Player(initiative: 12, name: "Player2", className: "Cleric", maxHP: 36, ac: 17, pp: 18)
    var charList = [charStruct]()
    var selectedChar : Character!
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initiativeTable.register(CharacterTableCell.self, forCellReuseIdentifier: "charCell")
        self.initiativeTable.register(CharacterDetailTableCell.self, forCellReuseIdentifier: "charDetailCell")
        
        self.initiativeTable.rowHeight = UITableView.automaticDimension
        
        self.charList = [charStruct(isOpened: false, charInfo: player1),
                         charStruct(isOpened: false, charInfo: player2)]
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return charList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if charList[section].isOpened {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 { // This cell is a CharacterTableCell
            tableView.register(UINib (nibName: "CharacterTableCell", bundle: nil), forCellReuseIdentifier: "charCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "charCell") as! CharacterTableCell
            
            let character = charList[indexPath.section].charInfo
            cell.initiativeLabel.text = String(character.initiative!)
            cell.nameLabel.text = character.name
            cell.hpLabel.text = String(character.currHP!) + " / " + String(character.maxHP!)
            let currHPPercent = Float(character.currHP!) / Float(character.maxHP!)
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
        else { // This is a CharacterDetailTableCell
            tableView.register(UINib (nibName: "CharacterDetailTableCell", bundle: nil), forCellReuseIdentifier: "charDetailCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "charDetailCell")as! CharacterDetailTableCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.character = charList[indexPath.section].charInfo
            cell.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { // This is a CharacterTableCell
            return UITableView.automaticDimension
        }
        else { // This is a CharacterDetailTableCell
            return 120
        }
    }
    
    // MARK: TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { // This is a CharacterTableCell
            if charList[indexPath.section].isOpened {
                charList[indexPath.section].isOpened = false
                
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else {
                charList[indexPath.section].isOpened = true
                
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        else { // This is a CharacterDetailTableCell
        }
    }
    
    // MARK: DetailCellDelegate Methods
    
    func segueFromDetailCell(character: Character) {
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
