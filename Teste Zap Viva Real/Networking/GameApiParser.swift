//
//  GameApiParser.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 12/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String:Any]

class GameApiParser: NSObject {

    static func parseGames(_ jsonDict: JSONDictionary) -> [Game]{
        var gameArray:[Game] =  []
        
        
        guard let gameDictArray = jsonDict["top"] as? [JSONDictionary] else{return []}
        for gameDict in gameDictArray {
            let game = Game()
            game.viewers =  gameDict["viewers"] as? Int
            guard let infoGameDict = gameDict["game"] as? JSONDictionary else {return []}
            game.name = infoGameDict["name"] as? String
            guard let logos = infoGameDict["box"] as? JSONDictionary else {return []}
            game.logoImage = RequestService.getImageFromUrl(urlStr: logos["large"] as! String)
            game.position = 0
            gameArray.append(game)
        }

        return gameArray
    }
    
}
