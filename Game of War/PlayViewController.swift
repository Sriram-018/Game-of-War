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
        cardDeck[0].shuffle()
        cardDeck[1].shuffle()
        cardDeck.shuffle()
        playerDeck = cardDeck[0]
        playerHand = []
        cpuDeck = cardDeck[1]
        cpuHand = []
        saveCounts = 0
        warOn = false
        warCardsCount = 0
        curRound = 0
        playerCardImageName = ""
        cpuCardImageName = ""
        saveData()
        loadData()
    }
    
    @IBAction func continueButton(_ sender: Any) { loadData() }
    
}
