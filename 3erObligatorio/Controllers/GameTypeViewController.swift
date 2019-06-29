//
//  GameTypeViewController.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/28/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//
import Foundation
import UIKit

class GameTypeViewController: UIViewController {
    @IBOutlet weak var classicGameButton: UIButton!
    @IBOutlet weak var categoryGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alterLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LevelsManager.shared.newGame()
        BonusManager.shared.newGame()
    }
    
    func alterLayout(){
        classicGameButton.layer.cornerRadius = 15
        categoryGameButton.layer.cornerRadius = 15
    }
    
    @IBAction func classicGameSelected(_ sender: Any) {
        CategoryManager.shared.playClassicGame()
    }
    
}

