//
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import Foundation
import UIKit

class CharacterTableCell : UITableViewCell {
    
    var initiative : Int?
    var name : String?
    var maxHP : Int?
    var currHP : Int?
    
    var initiativeView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var nameView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var hpView : UITextView = {
        var uiView = UITextView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(initiativeView)
        self.addSubview(nameView)
        self.addSubview(hpView)
        
        initiativeView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        initiativeView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        initiativeView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        initiativeView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        nameView.leftAnchor.constraint(equalTo: self.initiativeView.rightAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameView.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
        
        hpView.leftAnchor.constraint(equalTo: self.nameView.rightAnchor).isActive = true
        hpView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        hpView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        hpView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let initiative = initiative {
            initiativeView.text = String(initiative)
        }
        if let name = name {
            nameView.text = name
        }
        if let maxHP = maxHP, let currHP = currHP {
            hpView.text = String(currHP) + " / " + String(maxHP)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
