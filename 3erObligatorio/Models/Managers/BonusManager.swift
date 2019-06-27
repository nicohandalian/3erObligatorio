//
//  BonusManager.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/26/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation


class BonusManager {
    static let shared = BonusManager()
    var bonuses: [BonusType: Bool] = [:]
    
    private init() {
        bonuses[BonusType.callSomeone] = true
        bonuses[BonusType.changeQuestion] = true
        bonuses[BonusType.discardTwoOptions] = true
        bonuses[BonusType.doubleAnswer] = true
    }
    
}
