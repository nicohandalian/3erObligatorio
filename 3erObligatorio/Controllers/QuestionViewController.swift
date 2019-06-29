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
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var LevelLabel: UILabel!
    
    @IBOutlet weak var bonus1Button: UIButton!
    @IBOutlet weak var bonus2Button: UIButton!
    @IBOutlet weak var bonus3Button: UIButton!
    @IBOutlet weak var bonus4Button: UIButton!
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    var question: Question?
    var correctOption: Int?
    var options: [String]?
    var bonusUsed = false
    var doubleAnswerBonus = false
    
    override func viewDidLoad() {
        alterLayout()
        fetchQuestion()
    }
    
    func alterLayout(){
        questionTextView.isUserInteractionEnabled = false
        questionTextView.layer.cornerRadius = 15
        questionTextView.translatesAutoresizingMaskIntoConstraints = true
        
        activityIndicator.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        activityIndicator.hidesWhenStopped = true
        
        option1Button.layer.cornerRadius = 15
        option2Button.layer.cornerRadius = 15
        option3Button.layer.cornerRadius = 15
        option4Button.layer.cornerRadius = 15
        
    }
    
    func fetchQuestion(){
        LevelLabel.text! = "$" + LevelsManager.shared.actualLevel().rawValue
        hideElementsInView()
        activityIndicator.startAnimating()
        APIManager.shared.getQuestion(category: CategoryManager.shared.getNextCategory(), difficulty: LevelsManager.shared.actualDifficulty()){response,error in
            
            self.activityIndicator.stopAnimating()
            self.showElementsInView()
            
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
    
    
    func showElementsInView() {
        questionTextView.isHidden = false
        
        bonus1Button.isHidden = false
        bonus2Button.isHidden = false
        bonus3Button.isHidden = false
        bonus4Button.isHidden = false
        
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false
        
        
        option1Button.isEnabled = true
        option1Button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        
        option2Button.isEnabled = true
        option2Button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        
        option3Button.isEnabled = true
        option3Button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        
        option4Button.isEnabled = true
        option4Button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    }
    
    func hideElementsInView() {
        questionTextView.isHidden = true
        
        bonus1Button.isHidden = true
        bonus2Button.isHidden = true
        bonus3Button.isHidden = true
        bonus4Button.isHidden = true
        
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
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
        let loserAlert = UIAlertController(title: "Wrong Answer :(", message: "The correct answer was: \(options![correctOption!-1]).", preferredStyle: .alert)
        loserAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.indexHandler))
        self.present(loserAlert, animated: true, completion: nil)
        
    }
    
    func winnerAlert(){
        let winnerAlert = UIAlertController(title: "Congratulations!!", message: "Do you want to leave with \(LevelsManager.shared.actualLevel().rawValue) or keep going for \(LevelsManager.shared.nextLevel().rawValue)?", preferredStyle: .alert)
        winnerAlert.addAction(UIAlertAction(title: "Leave :(", style: .default, handler: self.indexHandler))
        winnerAlert.addAction(UIAlertAction(title: "Continue :)", style: .default, handler: self.nextQuestionHandler))
        self.present(winnerAlert, animated: true, completion: nil)
        
    }
    
    
    func millionaireAlert(){
        let winnerAlert = UIAlertController(title: "WOOOW!!", message: "You just became millionaire!", preferredStyle: .alert)
        winnerAlert.addAction(UIAlertAction(title: "Go back", style: .default, handler: self.indexHandler))
        winnerAlert.addAction(UIAlertAction(title: "Play again!", style: .default, handler: self.playAgainHandler))
        self.present(winnerAlert, animated: true, completion: nil)
    }
    
    func callSomeoneAlert(){
        let callSomeoneAlert = UIAlertController(title: "Call Bonus", message: "Your aunt says: 'I'm sure the answer is \(options![correctOption!-1])'.", preferredStyle: .alert)
        callSomeoneAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(callSomeoneAlert, animated: true, completion: nil)
    }
    
    func alreadyUsedBonus(){
        let alreadyUsedBonus = UIAlertController(title: "Bonus already used in this turn", message: "You can't use two bonus in one turn", preferredStyle: .alert)
        alreadyUsedBonus.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alreadyUsedBonus, animated: true, completion: nil)
        
    }
    
    func indexHandler(alert: UIAlertAction!){
        LevelsManager.shared.newGame()
        BonusManager.shared.newGame()
        navigationController?.popViewController(animated: true)
    }
    
    
    func playAgainHandler(alert: UIAlertAction!){
        LevelsManager.shared.newGame()
        BonusManager.shared.newGame()
        bonusUsed = false
        fetchQuestion()
    }
    
    func nextQuestionHandler(alert: UIAlertAction!){
        bonusUsed = false
        fetchQuestion()
    }
    
    @IBAction func bonus1Selected(_ sender: Any) {
        if(!bonusUsed){
            bonusUsed = true
            BonusManager.shared.useCallSomeone()
            bonus1Button.isEnabled = false
            bonus1Button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            callSomeoneAlert()
            
        }
        else{
            alreadyUsedBonus()
        }
    }
    
    @IBAction func bonus2Selected(_ sender: Any) {
        if(!bonusUsed){
            bonusUsed = true
            BonusManager.shared.useChangeQuestion()
            bonus2Button.isEnabled = false
            bonus2Button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            fetchQuestion()
        }
        else{
            alreadyUsedBonus()
        }
    }
    
    @IBAction func bonus3Selected(_ sender: Any) {
        if(!bonusUsed){
            bonusUsed = true
            BonusManager.shared.useDiscardTwoOptions()
            bonus3Button.isEnabled = false
            bonus3Button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            switch(correctOption!){
            case 1:
                option2Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option2Button.isEnabled = false
                option3Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option3Button.isEnabled = false

            case 2:
                option1Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option1Button.isEnabled = false
                option4Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option4Button.isEnabled = false

            case 3:
                option2Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option2Button.isEnabled = false
                option4Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option4Button.isEnabled = false

            case 4:
                option1Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option1Button.isEnabled = false
                option3Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option3Button.isEnabled = false

            default:
                option2Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option2Button.isEnabled = false
                option3Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                option3Button.isEnabled = false

            }
        }
        else{
            alreadyUsedBonus()
        }
        
    }
    
    @IBAction func bonus4Selected(_ sender: Any) {
        if(!bonusUsed){
            bonusUsed = true
            BonusManager.shared.useDoubleAnswer()
            bonus4Button.isEnabled = false
            bonus4Button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            doubleAnswerBonus = true
        }
        else{
            alreadyUsedBonus()
        }
    }
    
    @IBAction func option1Selected(_ sender: Any) {
        if(correctOption! == 1){
            doubleAnswerBonus = false
            if(LevelsManager.shared.actualLevel()==TriviaLevels.eight){
                millionaireAlert()
            }
            else{
                winnerAlert()
                LevelsManager.shared.progress()
            }
        }
        else{
            if(doubleAnswerBonus){
                doubleAnswerBonus = false
                option1Button.isEnabled = false
                option1Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }else{
                loserAlert()
            }
            
        }
    }
    @IBAction func option2Selected(_ sender: Any) {
        if(correctOption! == 2){
            doubleAnswerBonus = false
            if(LevelsManager.shared.actualLevel()==TriviaLevels.eight){
                millionaireAlert()
            }
            else{
                winnerAlert()
                LevelsManager.shared.progress()
            }
        }
        else{
            if(doubleAnswerBonus){
                doubleAnswerBonus = false
                option2Button.isEnabled = false
                option2Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }else{
                loserAlert()
            }
            
        }
    }
    @IBAction func option3Selected(_ sender: Any) {
        if(correctOption! == 3){
            doubleAnswerBonus = false
            if(LevelsManager.shared.actualLevel()==TriviaLevels.eight){
                millionaireAlert()
            }
            else{
                winnerAlert()
                LevelsManager.shared.progress()
            }
        }
        else{
            if(doubleAnswerBonus){
                doubleAnswerBonus = false
                option3Button.isEnabled = false
                option3Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }else{
                loserAlert()
            }
            
        }
    }
    @IBAction func option4Selected(_ sender: Any) {
        if(correctOption! == 4){
            doubleAnswerBonus = false
            if(LevelsManager.shared.actualLevel()==TriviaLevels.eight){
                millionaireAlert()
            }
            else{
                winnerAlert()
                LevelsManager.shared.progress()
            }
        }
        else{
            if(doubleAnswerBonus){
                doubleAnswerBonus = false
                option4Button.isEnabled = false
                option4Button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }else{
                loserAlert()
            }
            
        }
    }
}
