//
//  TopGamesCollectionViewCell.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 12/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit

class TopGamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var starIconButton: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameLogoView: UIImageView!
    var isBookmarked: Bool = false
    var game: Game?


    @IBAction func didPressStarButton(_ sender: Any) {
        if !isBookmarked {
            starIconButton.setBackgroundImage(UIImage(named:"black_star"), for: .normal)
            isBookmarked = true
            
            _ = DataBaseManager.saveFavorite(gameObject: self.game!)
        }
        else {
            starIconButton.setBackgroundImage(UIImage(named:"star_border_black"), for: .normal)
            isBookmarked = false
        }
    }
    
}
