//
//  RoundedButton.swift
//  IUE-Worksheet4
//
//  Created by João Ramos on 30/10/2019.
//  Copyright © 2019 João Ramos. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = bounds.height / 2
    }
}
