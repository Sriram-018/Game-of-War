//
//  GameModal.swift
//  Game of War
//
//  Created by Sriram R on 05/06/23.
//

import SwiftUI

class GameModal {
    
    static private let cardDeck = Cards().createCards()
    private(set) var playerDeck = cardDeck[0]
    private(set) var playerHand = [Cards]()
    private(set) var cpuDeck = cardDeck[1]
    private(set) var cpuHand = [Cards]()
    
    @AppStorage("saveCounts") private(set) var sC = 0
    @AppStorage("warOn") private(set) var wO = false
    @AppStorage("warCardsCount") private(set) var wCC = 0
    @AppStorage("curRound") private(set) var cR = 0
    @AppStorage("playerCardImage") private(set) var pCIN = ""
    @AppStorage("cpuCardImageName") private(set) var cCIN = ""

    func addCardsToBothHand() {
        playerHand.append(playerDeck.popLast()!)
        cpuHand.append(cpuDeck.popLast()!)
    }
    func checkCards() {
        if playerHand[playerHand.count-1].value > cpuHand[cpuHand.count-1].value{
            wO = false
            wCC = 0
            addToPlayerCards()
        } else if playerHand[playerHand.count-1].value < cpuHand[cpuHand.count-1].value{
            wO = false
            wCC = 0
            addToCPUCards()
        } else{
            wO = true
        }
    }
    func checkCardsForWar() {
        setCardsImageAsBack()
        wCC += 1
        if wCC % 4 == 0 {
            setCardsImageAsValue()
            checkCards()
        }
    }
    
    func setCardsImageAsBack() {
        pCIN = "back_card"
        cCIN = "back_card"
    }
    func setCardsImageAsValue() {
        pCIN = playerHand[playerHand.count-1].name
        cCIN = cpuHand[cpuHand.count-1].name
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
    
    func addSaveCounts() {sC += 1}
    func addWarCardsCount() {wCC+=1}
    func resetWarCount() {wCC=0}
    func addCurRound() {cR+=1}
    
    func warSetFalse() {wO = false}
    func warSetTrue() {wO = true}
    
    func saveData() {
        sC += 1
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
        if sC != 0{
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
    
    func resetVariables() {
        playerDeck.shuffle()
        cpuDeck.shuffle()
        playerHand = [Cards]()
        cpuHand = [Cards]()
        sC = 0
        wO = false
        wCC = 0
        cR = 0
        pCIN = ""
        cCIN = ""
        saveData()
    }
}
