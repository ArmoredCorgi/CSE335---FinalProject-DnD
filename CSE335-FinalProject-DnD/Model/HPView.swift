//
//  HPView.swift
//  CSE335-FinalProject-DnD
//
//  Created by Nicholas Jorgensen on 3/11/19.
//  Copyright © 2019 Nicholas Jorgensen. All rights reserved.
//

import UIKit

class HPView: UIView {

    var maxHP : Int?
    var currHP : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
    }

}
