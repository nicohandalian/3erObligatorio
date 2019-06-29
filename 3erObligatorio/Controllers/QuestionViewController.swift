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
    var correctOption: Int?
    var options: [String]?
    
    override func viewDidLoad() {
        alterLayout()
        fetchQuestion()
    }
    
    func alterLayout(){
        questionTextView.isUserInteractionEnabled = false
        questionTextView.layer.cornerRadius = 15
        questionTextView.translatesAutoresizingMaskIntoConstraints = true
        option1Button.layer.cornerRadius = 15
        option2Button.layer.cornerRadius = 15
        option3Button.layer.cornerRadius = 15
        option4Button.layer.cornerRadius = 15
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
        
        options = shuffleOptions(correct: question!.correct_answer!, incorrects: question!.incorrect_answers!)
        
        option1Button.setTitle(options![0], for:.normal)
        
        option2Button.setTitle(options![1], for:.normal)
        
        option3Button.setTitle(options![2], for:.normal)
        
        option4Button.setTitle(options![3], for:.normal)
        
    }
    
    func shuffleOptions(correct:String, incorrects:[String])->[String]{
        let randomOptions = Int.random(in: 0...3)
        var op1 = ""
        var op2 = ""
        var op3 = ""
        var op4 = ""
        switch randomOptions {
            case 0:
                correctOption = 1
                op1 = correct + "."
                op2 = incorrects[0]
                op3 = incorrects[1]
                op4 = incorrects[2]
            case 1:
                correctOption = 2
                op1 = incorrects[0]
                op2 = correct + "."
                op3 = incorrects[1]
                op4 = incorrects[2]
            case 2:
                correctOption = 3
                op1 = incorrects[0]
                op2 = incorrects[1]
                op3 = correct + "."
                op4 = incorrects[2]
            case 3:
                correctOption = 4
                op1 = incorrects[0]
                op2 = incorrects[1]
                op3 = incorrects[2]
                op4 = correct + "."
            default:
                correctOption = 4
                op1 = incorrects[0]
                op2 = incorrects[1]
                op3 = incorrects[2]
                op4 = correct + "."
            
        }
        return [op1,op2,op3,op4]
    }
    
    func loserAlert(){
        let loserAlert = UIAlertController(title: "Wrong Answer :(", message: "The correct answer was: \(options![correctOption!])", preferredStyle: .alert)
        loserAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.indexHandler))
        self.present(loserAlert, animated: true, completion: nil)
        
    }
    
    func indexHandler(alert: UIAlertAction!){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func option1Selected(_ sender: Any) {
        if(correctOption! == 1){
            
        }
        else{
            loserAlert()
        }
    }
    @IBAction func option2Selected(_ sender: Any) {
        if(correctOption! == 2){
            
        }
        else{
            loserAlert()
            
        }
    }
    @IBAction func option3Selected(_ sender: Any) {
        if(correctOption! == 3){
            
        }
        else{
            loserAlert()
            
        }
    }
    @IBAction func option4Selected(_ sender: Any) {
        if(correctOption! == 4){
            
        }
        else{
            loserAlert()
            
        }
    }
    
    
}
