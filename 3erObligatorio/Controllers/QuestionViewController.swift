//
//  QuestionViewController.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/27/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController{
    var question: Question?
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    override func viewDidLoad() {
        alterLayout()
        fetchQuestion()
    }
    
    func alterLayout(){
        questionTextView.isUserInteractionEnabled = false
    }
    
    func fetchQuestion(){
        APIManager.shared.getQuestion(category: CategoryManager.shared.getNextCategory(), difficulty: LevelsManager.shared.actualDifficulty()){response,error in
            if let error = error{
                let errorAlert = UIAlertController(title: "Failed loading purchases", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
            if let response = response{
                self.question = response.results![0]
                self.updateView()
            }
        }
    }
    
    func updateView(){
        questionTextView.text = question!.question
        questionTextView.sizeToFit()
        let options = shuffleOptions(correct: question!.correct_answer!, incorrects: question!.incorrect_answers!)
        
        option1Button.setTitle(options[0], for:.normal)
        
        option2Button.setTitle(options[1], for:.normal)
        
        option3Button.setTitle(options[2], for:.normal)
        
        option4Button.setTitle(options[3], for:.normal)
        
    }
    
    func shuffleOptions(correct:String, incorrects:[String])->[String]{
        let randomOptions = Int.random(in: 0...3)
        var op1 = ""
        var op2 = ""
        var op3 = ""
        var op4 = ""
        switch randomOptions {
            case 0:
                op1 = correct + "."
                op2 = incorrects[0]
                op3 = incorrects[1]
                op4 = incorrects[2]
            case 1:
                op1 = incorrects[0]
                op2 = correct + "."
                op3 = incorrects[1]
                op4 = incorrects[2]
            case 2:
                op1 = incorrects[0]
                op2 = incorrects[1]
                op3 = correct + "."
                op4 = incorrects[2]
            case 3:
                op1 = incorrects[0]
                op2 = incorrects[1]
                op3 = incorrects[2]
                op4 = correct + "."
            default:
                op1 = incorrects[0]
                op2 = incorrects[1]
                op3 = incorrects[2]
                op4 = correct + "."
            
        }
        return [op1,op2,op3,op4]
    }
    
}
