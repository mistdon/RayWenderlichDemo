//
//  Player.swift
//  RayCoreConcepts_SB1
//
//  Created by shendong on 16/8/31.
//  Copyright © 2016年 shendong. All rights reserved.
//

import Foundation

struct Player {
    var name: String?
    var game: String?
    var rating: Int
    init(name: String?, game: String?, rating: Int){
        self.name = name
        self.game = game
        self.rating = rating
    }
}