//
//  CategoriesViewController.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/28/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet weak var sportsCategoryButton: UIButton!
    @IBOutlet weak var computersCategoryButton: UIButton!
    @IBOutlet weak var mythologyCategoryButton: UIButton!
    @IBOutlet weak var filmsCategoryButton: UIButton!
    @IBOutlet weak var mathsCategoryButton: UIButton!
    @IBOutlet weak var generalCategoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alterLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LevelsManager.shared.newGame()
        BonusManager.shared.newGame()
    }
    
    func alterLayout(){
        sportsCategoryButton.layer.cornerRadius = 15
        computersCategoryButton.layer.cornerRadius = 15
        mythologyCategoryButton.layer.cornerRadius = 15
        filmsCategoryButton.layer.cornerRadius = 15
        mathsCategoryButton.layer.cornerRadius = 15
        generalCategoryButton.layer.cornerRadius = 15
    }
    
    @IBAction func sportsCategorySelected(_ sender: Any) {
        CategoryManager.shared.playCategoryGame(category:QuestionCategory.sports)
    }
    
    @IBAction func computersCategorySelected(_ sender: Any) {
        CategoryManager.shared.playCategoryGame(category:QuestionCategory.computers)
    }
    
    @IBAction func mythologyCategorySelected(_ sender: Any) {
        CategoryManager.shared.playCategoryGame(category:QuestionCategory.mythology)
    }
    
    @IBAction func filmsCategorySelected(_ sender: Any) {
        CategoryManager.shared.playCategoryGame(category:QuestionCategory.films)
    }
    
    @IBAction func mathsCategorySelected(_ sender: Any) {
        CategoryManager.shared.playCategoryGame(category:QuestionCategory.maths)
    }
    
    @IBAction func generalCategorySelected(_ sender: Any) {
        CategoryManager.shared.playCategoryGame(category:QuestionCategory.general)
    }
}
