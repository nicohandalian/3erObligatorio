//
//  CategoryManager.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/27/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class CategoryManager {
    static let shared = CategoryManager()
    
    private init() {
    }
    
    func getNextCategory()->QuestionCategory{
        let next = Int.random(in: 0...5)
        switch next {
        case 0:
            return QuestionCategory.computers
        case 1:
            return QuestionCategory.computers
        case 2:
            return QuestionCategory.computers
        case 3:
            return QuestionCategory.computers
        case 4:
            return QuestionCategory.computers
        case 5:
            return QuestionCategory.computers
        default:
            return QuestionCategory.general
        }
    }
    
}
