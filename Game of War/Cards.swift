//
//  Cards.swift
//  War Game
//
//  Created by Sriram R on 11/05/23.
//

import Foundation

struct Cards: Encodable, Decodable {
    
    var name: String = ""
    var value: Int = 0
    
}

extension Cards {
    
    func createCards() -> [[Cards]]{
        
        var (cardList, playerCards, cpuCards) = ( [Cards]() , [Cards]() , [Cards]() )
        
        for suit in 0...3{
            for cardNumber in 0...12{
                cardList.append(Cards(name: "\(suit)_\(cardNumber)", value: cardNumber))
            }
        }
        
        for index in 0...25{
            playerCards.append(cardList[index])
            cpuCards.append(cardList[51-index])
        }
        
        playerCards.shuffle()
        cpuCards.shuffle()
        
        return [playerCards, cpuCards]
    }
    
}
