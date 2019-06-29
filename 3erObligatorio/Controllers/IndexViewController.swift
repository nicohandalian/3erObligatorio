//
//  ViewController.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/13/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alterLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LevelsManager.shared.newGame()
        BonusManager.shared.newGame()
    }
    func alterLayout(){
        newGameButton.layer.cornerRadius = 15
    }


}

