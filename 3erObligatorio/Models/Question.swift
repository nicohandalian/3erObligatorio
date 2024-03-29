//
//  Question.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/17/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Question: Mappable {
    var questionCategory: QuestionCategory?
    var type: String?
    var questionDifficulty: QuestionDifficulty?
    var questionString:String?
    var question: String?{didSet{
        let decodedData = Data(base64Encoded: question!)!
        questionString = String(data: decodedData, encoding: .utf8)!
        }
        
    }
    var correctAnswerString:String?
    var correct_answer: String?{
        didSet{
            let decodedData = Data(base64Encoded: correct_answer!)!
            correctAnswerString = String(data: decodedData, encoding: .utf8)!
        }
    }
    var incorrectAnswersString:[String] = []
    var incorrect_answers: [String]?{
        didSet{
            for answer in incorrect_answers!{
                let decodedData = Data(base64Encoded: answer)!
                incorrectAnswersString.append(String(data: decodedData, encoding: .utf8)!)
            }
        }
        
    }
    
    var category: String?{
        didSet{
            switch category!.capitalized {
            case "Mythology":
                questionCategory = .mythology
                break
            case "Sports":
                questionCategory = .sports
                break
            case "Computers":
                questionCategory = .computers
                break
            case "Films":
                questionCategory = .films
                break
            case "Maths":
                questionCategory = .maths
                break
            case "General Knowledge":
                questionCategory = .general
                break
            default:
                questionCategory = .general
                break
            }
        }
    }
    
    var difficulty: String?{
        didSet{
            switch difficulty!.capitalized {
            case "easy":
                questionDifficulty = .easy
                break
            case "medium":
                questionDifficulty = .medium
                break
            case "hard":
                questionDifficulty = .hard
                break
            default:
                questionDifficulty = .easy
                break
            }
        }
    }
    
    required init?(map: Map) {
        if map.JSON["question"] == nil { return nil }
        if map.JSON["correct_answer"] == nil { return nil }
        if map.JSON["incorrect_answers"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        question <- map["question"]
        correct_answer <- map["correct_answer"]
        incorrect_answers <- map["incorrect_answers"]
        category <- map["category"]
        difficulty <- map["difficulty"]
    }
}
