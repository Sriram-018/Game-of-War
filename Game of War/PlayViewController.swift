//
//  PlayViewController.swift
//  War Game
//
//  Created by Sriram R on 11/05/23.
//

import UIKit

class PlayViewController: GameViewController{

    override func viewDidLoad() { /* Do Nothing */ }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        GameViewController().game.resetVariables()
    }
    
    @IBAction func continueButton(_ sender: Any) { GameViewController().game.loadData() }
    
}
