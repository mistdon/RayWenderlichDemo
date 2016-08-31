//
//  PlayerCell.swift
//  RayCoreConcepts_SB1
//
//  Created by shendong on 16/8/31.
//  Copyright © 2016年 shendong. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    func imageForRating(rating: Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
    var player: Player!{
        didSet{
            gameLabel.text = player.game
            nameLabel.text = player.name
            ratingImageView.image = imageForRating(player.rating)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
