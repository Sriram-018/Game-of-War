//
//  GameData.swift
//  Game of War
//
//  Created by Sriram R on 05/06/23.
//

import Foundation

class GameData {
    
    let game = GameModal()
    
    var playerDeck: [Cards] {game.playerDeck}
    var playerHand: [Cards] {game.playerHand}
    var cpuDeck: [Cards] {game.cpuDeck}
    var cpuHand: [Cards] {game.cpuHand}

    var saveCounts: Int {game.sC}
    var warOn: Bool {game.wO}
    var warCardsCount: Int {game.wCC}
    var curRound: Int {game.cR}
    var playerCardImageName: String {game.pCIN}
    var cpuCardImageName: String {game.cCIN}
    
    func addCardsToBothHand() {game.addCardsToBothHand()}
    func addToPlayerCards() {game.addToPlayerCards()}
    func addToCPUCards() {game.addToCPUCards()}
    func checkCards() {game.checkCards()}
    func checkCardsForWar() {game.checkCardsForWar()}
    func setCardsImageAsBack() {game.setCardsImageAsBack()}
    func setCardsImageAsValue() {game.setCardsImageAsValue()}
    func addSaveCounts() {game.addSaveCounts()}
    func addWarCardsCount() {game.addWarCardsCount()}
    func resetWarCount() {game.resetWarCount()}
    func addCurRound() {game.addCurRound()}
    func warSetFalse() {game.warSetFalse()}
    func warSetTrue() {game.warSetTrue()}
    func saveData() {game.saveData()}
    func loadData() {game.loadData()}
    func resetVariables() {game.resetVariables()}
}

