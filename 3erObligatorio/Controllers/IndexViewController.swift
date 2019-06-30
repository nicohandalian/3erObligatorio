//
//  ViewController.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/13/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class IndexViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var animationView: AnimationView!
    
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
        startQuestionAnimation()
    }
    
    
    func startQuestionAnimation(){
        
        animationView!.isHidden = false
        let animation = Animation.named("animation-w100-h100")
        animationView.loopMode = .autoReverse
        animationView!.animation = animation
        animationView!.play()
        
    }


}

