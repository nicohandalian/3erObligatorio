//
//  BonusManager.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/26/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation


class LevelsManager {
    static let shared = LevelsManager()
    var levelsDifficulty: [(TriviaLevels,QuestionDifficulty)] = []
    var actual = 0
    
    private init() {
        levelsDifficulty.append((TriviaLevels.one, QuestionDifficulty.easy))
        levelsDifficulty.append((TriviaLevels.two, QuestionDifficulty.easy))
        levelsDifficulty.append((TriviaLevels.three, QuestionDifficulty.easy))
        levelsDifficulty.append((TriviaLevels.four, QuestionDifficulty.medium))
        levelsDifficulty.append((TriviaLevels.five, QuestionDifficulty.medium))
        levelsDifficulty.append((TriviaLevels.six, QuestionDifficulty.medium))
        levelsDifficulty.append((TriviaLevels.seven, QuestionDifficulty.hard))
        levelsDifficulty.append((TriviaLevels.eight, QuestionDifficulty.hard))
    }
    
    func nextLevel(){
        actual += 1
    }
    
}
