//
//  News.swift
//  AppleMusicApp
//
//  Created by Tunay Biçer on 30.09.2024.
//

import Foundation

class News {
    var id:Int?
    var headline:String?
    var title:String?
    var image:String?
    
    init(id: Int, headline: String, title: String, image: String) {
        self.id = id
        self.headline = headline
        self.title = title
        self.image = image
    }
}
