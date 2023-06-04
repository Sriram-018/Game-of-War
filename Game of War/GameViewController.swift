//
//  GameViewController.swift
//  War Game
//
//  Created by Sriram R on 11/05/23.
//

import UIKit
import SwiftUI

var cardDeck = Cards().createCards()
var playerDeck = cardDeck[0]
var playerHand = [Cards]()
var cpuDeck = cardDeck[1]
var cpuHand = [Cards]()

class GameViewController: UIViewController {
    
    @AppStorage("saveCounts") var saveCounts = 0
    @AppStorage("warOn") var warOn = false
    @AppStorage("warCardsCount") var warCardsCount = 0
    @AppStorage("curRound") var curRound = 0
    @AppStorage("playerHandLastCardImage") var playerCardImageName = ""
    @AppStorage("cpuHandLastCardImage") var cpuCardImageName = ""
    
    @IBOutlet weak var reasonForLoseOrWinLabel: UILabel!
    @IBOutlet weak var loseOrWinLabel: UILabel!
    @IBOutlet weak var playerCardImage: UIImageView!
    @IBOutlet weak var cpuCardImage: UIImageView!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var cpuScoreLabel: UILabel!
    @IBOutlet weak var curRoundText: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func backButton(_ sender: UIButton) { saveData() }
    @IBAction func dealButton(_ sender: UIButton) {
        addCardsToBothHand()
        if !(warOn){
            curRound += 1
            curRoundText.text = "Round \(curRound)"
            checkCards()
        } else{
            checkCardsForWar()
        }
        updateCards()
        updateScore()
        saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        updateCards()
        updateScore()
        if warOn{
            curRoundText.text = "Round \(curRound) WAR"
        } else {
            curRoundText.text = "Round \(curRound)"
        }
    }
    func addCardsToBothHand() {
        playerHand.append(playerDeck.popLast()!)
        cpuHand.append(cpuDeck.popLast()!)
        playerCardImageName = playerHand[playerHand.count-1].name
        cpuCardImageName = cpuHand[cpuHand.count-1].name
    }
    func checkCards() {
        if playerHand[playerHand.count-1].value > cpuHand[cpuHand.count-1].value{
            warOn = false
            warCardsCount = 0
            addToPlayerCards()
        } else if playerHand[playerHand.count-1].value < cpuHand[cpuHand.count-1].value{
            warOn = false
            warCardsCount = 0
            addToCPUCards()
        } else{
            warOn = true
            curRoundText.text = "Round \(curRound) WAR"
        }
    }
    func checkCardsForWar() {
        playerCardImageName = "back_card"
        cpuCardImageName = "back_card"
        warCardsCount += 1
        // Check the face up card
        if warCardsCount % 4 == 0 {
            playerCardImageName = playerHand[playerHand.count-1].name
            cpuCardImageName = cpuHand[cpuHand.count-1].name
            checkCards()
            // Check if anyone ran out of cards for war
        } else {
            if playerDeck.isEmpty{
                updateScore()
                loseOrWinLabel.text = "CPU WINS!!!"
                reasonForLoseOrWinLabel.text = "Player ran out of cards for war."
                dealButton.isEnabled = false
            } else if cpuDeck.isEmpty{
                updateScore()
                loseOrWinLabel.text = "PLAYER WINS!!!"
                reasonForLoseOrWinLabel.text = "CPU ran out of cards for war."
                dealButton.isEnabled = false
            }
        }
    }
    func updateCards() {
        playerCardImage.image = UIImage(named: playerCardImageName)
        cpuCardImage.image = UIImage(named: cpuCardImageName)
    }
    func updateScore() {
        if playerDeck.count == 0{
            loseOrWinLabel.text = "CPU WINS!!!"
            reasonForLoseOrWinLabel.text = "Player ran out of cards."
            dealButton.isEnabled = false
        } else if cpuDeck.count == 0{
            loseOrWinLabel.text = "PLAYER WINS!!!"
            reasonForLoseOrWinLabel.text = "CPU ran out of cards."
            dealButton.isEnabled = false
        }
        playerScoreLabel.text = String(playerDeck.count)
        cpuScoreLabel.text = String(cpuDeck.count)
    }
    func addToPlayerCards() {
        while playerHand.count != 0{
            playerDeck.insert(playerHand.popLast()!, at: 0)
        }
        while cpuHand.count != 0{
            playerDeck.insert(cpuHand.popLast()!, at: 0)
        }
    }
    func addToCPUCards() {
        while cpuHand.count != 0{
            cpuDeck.insert(cpuHand.popLast()!, at: 0)
        }
        while playerHand.count != 0{
            cpuDeck.insert(playerHand.popLast()!, at: 0)
        }
    }
    func saveData() {
        saveCounts += 1
        do {
            let playerCardsEncodedData = try JSONEncoder().encode(playerDeck)
            UserDefaults.standard.set(playerCardsEncodedData, forKey: "playerCards")
            let cpuCardsEncodedData = try JSONEncoder().encode(cpuDeck)
            UserDefaults.standard.set(cpuCardsEncodedData, forKey: "cpuCards")
            let playerHandEncodedData = try JSONEncoder().encode(playerHand)
            UserDefaults.standard.set(playerHandEncodedData, forKey: "playerHand")
            let cpuHandEncodedData = try JSONEncoder().encode(cpuHand)
            UserDefaults.standard.set(cpuHandEncodedData, forKey: "cpuHand")
        } catch {
            // Failed to save data.
        }
    }
    func loadData() {
        if saveCounts != 0{
            if let pcSavedData = UserDefaults.standard.object(forKey: "playerCards") as? Data {
                do{
                    playerDeck = try JSONDecoder().decode([Cards].self, from: pcSavedData)
                } catch {
                    // Failed to read.
                }
            }
            if let ccSavedData = UserDefaults.standard.object(forKey: "cpuCards") as? Data {
                do{
                    cpuDeck = try JSONDecoder().decode([Cards].self, from: ccSavedData)
                } catch {
                    // Failed to read.
                }
            }
            if let phSavedData = UserDefaults.standard.object(forKey: "playerHand") as? Data {
                do{
                    playerHand = try JSONDecoder().decode([Cards].self, from: phSavedData)
                } catch {
                    // Failed to read.
                }
            }
            if let chSavedData = UserDefaults.standard.object(forKey: "cpuHand") as? Data {
                do{
                    cpuHand = try JSONDecoder().decode([Cards].self, from: chSavedData)
                } catch {
                    // Failed to read.
                }
            }
        }
    }

}
