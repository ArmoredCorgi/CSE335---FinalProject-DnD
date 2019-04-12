//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailTableCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var bliButton: UIButton!
    @IBOutlet weak var chaButton: UIButton!
    @IBOutlet weak var deafButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var grapButton: UIButton!
    @IBOutlet weak var invButton: UIButton!
    
    // MARK: Variables
    
    var character : Character!
    var delegate : DetailCellDelegate!
    
    // MARK: IBActions
    
    @IBAction func detailsButtonTapped(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.segueFromDetailCell(character: character)
        }
    }
    
    @IBAction func minus1Tapped(_ sender: Any) {
        if(character.currHP! > 0) {
            character.currHP! -= 1
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableNotif"), object: nil)
    }
    
    @IBAction func plus1Tapped(_ sender: Any) {
        if(character.currHP! < character.maxHP!) {
            character.currHP! += 1
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableNotif"), object: nil)
    }
    
    @IBAction func minus5Tapped(_ sender: Any) {
        if(character.currHP! >= 5){
            character.currHP! -= 5
        }
        else {
            character.currHP! = 0
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableNotif"), object: nil)
    }
    
    @IBAction func plus5Tapped(_ sender: Any) {
        if(character.currHP! <= character.maxHP! - 5){
            character.currHP! += 5
        }
        else {
            character.currHP! = character.maxHP!
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableNotif"), object: nil)
    }
}
