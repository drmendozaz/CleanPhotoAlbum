//
//  Photo.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//
typealias Photos = [Photo]

struct Photo: Codable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}
