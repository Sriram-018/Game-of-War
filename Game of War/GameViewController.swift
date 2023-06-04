//
//  GameViewController.swift
//  War Game
//
//  Created by Sriram R on 11/05/23.
//

import UIKit
import SwiftUI

class GameViewController: UIViewController {
    
    let game = GameData()
    
    @IBOutlet weak var reasonForLoseOrWinLabel: UILabel!
    @IBOutlet weak var loseOrWinLabel: UILabel!
    @IBOutlet weak var playerCardImage: UIImageView!
    @IBOutlet weak var cpuCardImage: UIImageView!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var cpuScoreLabel: UILabel!
    @IBOutlet weak var curRoundText: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func backButton(_ sender: UIButton) { game.saveData() }
    @IBAction func dealButton(_ sender: UIButton) {
        if game.warOn{
            curRoundText.text = "Round \(game.curRound) WAR"
        } else {
            curRoundText.text = "Round \(game.curRound)"
        }
        game.addCardsToBothHand()
        game.setCardsImageAsValue()
        if !(game.warOn){
            game.addCurRound()
            curRoundText.text = "Round \(game.curRound)"
            game.checkCards()
        } else{
            game.checkCardsForWar()
        }
        updateCards()
        updateScore()
        game.saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.loadData()
        updateCards()
        updateScore()
        if game.warOn{
            curRoundText.text = "Round \(game.curRound) WAR"
        } else {
            curRoundText.text = "Round \(game.curRound)"
        }
    }
    
    func updateCards() {
        playerCardImage.image = UIImage(named: game.playerCardImageName)
        cpuCardImage.image = UIImage(named: game.cpuCardImageName)
    }
    func updateScore() {
        if game.playerDeck.count == 0{
            loseOrWinLabel.text = "CPU WINS!!!"
            reasonForLoseOrWinLabel.text = "Player ran out of cards."
            dealButton.isEnabled = false
        } else if game.cpuDeck.count == 0{
            loseOrWinLabel.text = "PLAYER WINS!!!"
            reasonForLoseOrWinLabel.text = "CPU ran out of cards."
            dealButton.isEnabled = false
        }
        playerScoreLabel.text = String(game.playerDeck.count)
        cpuScoreLabel.text = String(game.cpuDeck.count)
    }

}
