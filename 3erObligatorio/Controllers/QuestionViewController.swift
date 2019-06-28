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
        
        option1Button.setTitle(question!.correct_answer, for:.normal)
        
        option2Button.setTitle(question!.incorrect_answers![0], for:.normal)
        
        option3Button.setTitle(question!.incorrect_answers![1], for:.normal)
        
        option4Button.setTitle(question!.incorrect_answers![2], for:.normal)
        
    }
    
}
