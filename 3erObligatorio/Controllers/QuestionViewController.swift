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
    
    override func viewDidLoad() {
        fetchQuestion()
    }
    
    func fetchQuestion(){
        APIManager.shared.getQuestion(category: QuestionCategory.general, difficulty: LevelsManager.shared.actualDifficulty()){response,error in
            if let error = error{
                let errorAlert = UIAlertController(title: "Failed loading purchases", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
            if let response = response{
                self.question = response.results![0]
            }
        }
    }
    
}
