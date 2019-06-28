//
//  ImageView.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/6/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setRoundedCorners() {
        self.layer.cornerRadius = self.frame.width/15
        self.layer.masksToBounds = true
    }
    
    func setRounded() {
        self.layer.cornerRadius = self.frame.width/1.6
        self.layer.masksToBounds = true
    }
}
