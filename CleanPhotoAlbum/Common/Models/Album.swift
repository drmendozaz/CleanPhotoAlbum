//
//  Album.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

typealias Albums = [Album]

struct Album: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
    }
}

