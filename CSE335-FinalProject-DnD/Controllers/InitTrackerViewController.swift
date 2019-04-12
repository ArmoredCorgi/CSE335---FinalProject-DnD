//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit
import CoreData

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
    let player1 : Player = Player(initiative: 16, name: "Player1", className: "Paladin", maxHP: 30, ac: 14, pp: 14, image: UIImage(named: "paladin")?.pngData())
    let player2 : Player = Player(initiative: 12, name: "Player2", className: "Cleric", maxHP: 36, ac: 17, pp: 18, image: UIImage(named: "cleric")?.pngData())
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
        
        //Core Data:
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let newPlayer1 = NSEntityDescription.insertNewObject(forEntityName: "PlayerEntity", into: managedContext)
        newPlayer1.setValue(player1.name!, forKey: "name")
        newPlayer1.setValue(player1.className!, forKey: "charClass")
        newPlayer1.setValue(player1.image!, forKey: "image")
        newPlayer1.setValue(player1.initiative!, forKey: "initiative")
        newPlayer1.setValue(player1.maxHP!, forKey: "maxHP")
        newPlayer1.setValue(player1.pp!, forKey: "pp")
        
        let newPlayer2 = NSEntityDescription.insertNewObject(forEntityName: "PlayerEntity", into: managedContext)
        newPlayer2.setValue(player2.name!, forKey: "name")
        newPlayer2.setValue(player2.className!, forKey: "charClass")
        newPlayer2.setValue(player2.image!, forKey: "image")
        newPlayer2.setValue(player2.initiative!, forKey: "initiative")
        newPlayer2.setValue(player2.maxHP!, forKey: "maxHP")
        newPlayer2.setValue(player2.pp!, forKey: "pp")
        
        do {
            try managedContext.save()
            print("Saved")
        } catch {
            print("ERROR: saving failed")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTableNotif") , object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Initiative Tracker"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 24)!]
        
        for char in charList {
            if (char.charInfo.currHP! > char.charInfo.maxHP!) {
                char.charInfo.currHP! = char.charInfo.maxHP!
            }
        }
        
        initiativeTable.reloadData()
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
            cell.imageView!.image = UIImage(data: character.image!)
            cell.hpLabel.text = String(character.currHP!) + " / " + String(character.maxHP!)
            let currHPPercent = Float(character.currHP!) / Float(character.maxHP!)
            let bgWidth = cell.backgroundHPBar.frame.width
            let currHPWidth = bgWidth * CGFloat(currHPPercent)
            cell.currHPWidth.constant = currHPWidth
            cell.updateConstraints()
            
            return cell
        }
        else { // This is a CharacterDetailTableCell
            tableView.register(UINib (nibName: "CharacterDetailTableCell", bundle: nil), forCellReuseIdentifier: "charDetailCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "charDetailCell")as! CharacterDetailTableCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.character = charList[indexPath.section].charInfo
            cell.bliButton.isHidden = cell.character!.conditions?.firstIndex(of: "Blinded") == nil
            cell.chaButton.isHidden = cell.character!.conditions?.firstIndex(of: "Charmed") == nil
            cell.deafButton.isHidden = cell.character!.conditions?.firstIndex(of: "Deafened") == nil
            cell.friButton.isHidden = cell.character!.conditions?.firstIndex(of: "Frightened") == nil
            cell.grapButton.isHidden = cell.character!.conditions?.firstIndex(of: "Grappled") == nil
            cell.invButton.isHidden = cell.character!.conditions?.firstIndex(of: "Invisible") == nil
            
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
    
    // MARK: Private Methods
    
    @objc func reloadTable() {
        initiativeTable.reloadData()
    }
}
