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
    var bonusesAvailable: [BonusType: Bool] = [:]
    
    private init() {
    }
    
    func newGame(){
        bonusesAvailable[BonusType.callSomeone] = true
        bonusesAvailable[BonusType.changeQuestion] = true
        bonusesAvailable[BonusType.discardTwoOptions] = true
        bonusesAvailable[BonusType.doubleAnswer] = true
        
    }
    
    func useCallSomeone(){
        bonusesAvailable[BonusType.callSomeone] = false
    }
    func useChangeQuestion(){
        bonusesAvailable[BonusType.changeQuestion] = false
    }
    func useDiscardTwoOptions(){
        bonusesAvailable[BonusType.discardTwoOptions] = false
    }
    func useDoubleAnswer(){
        bonusesAvailable[BonusType.doubleAnswer] = false
    }
    
}
