//
//  Album.swift
//  AppleMusicApp
//
//  Created by Tunay Biçer on 1.10.2024.
//

import Foundation

class Album {
    var id:Int?
    var title:String?
    var image:String?
    
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
}
