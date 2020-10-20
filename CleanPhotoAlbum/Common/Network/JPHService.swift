//
//  JPHService.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Moya

enum JPHService{
    case getAlbums
    case getPhotos
    case getAlbumPhotos(albumId: String)
}

extension JPHService: TargetType, CachePolicyGettableType{
    var cachePolicy: URLRequest.CachePolicy? {
        return .useProtocolCachePolicy
    }
    
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getAlbums:
            return "/albums"
        case .getPhotos:
            return "/photos"
        case .getAlbumPhotos(let albumId):
            return "/albums/\(albumId)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAlbums, .getPhotos, .getAlbumPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getAlbums:
            return "{\"userId\": \"1\", \"id\": \"1\", \"title\": \"quidem molestiae enim\"}".utf8Encoded
        case .getPhotos:
            return "{\"albumId\": \"1\", \"id\": \"1\", \"title\": \"accusamus beatae ad facilis cum similique qui sunt\", \"url\": \"https://via.placeholder.com/600/92c952\"}".utf8Encoded
        case .getAlbumPhotos(let albumId):
            return "{\"albumId\": \(albumId), \"id\": \"1\", \"title\": \"accusamus beatae ad facilis cum similique qui sunt\", \"url\": \"https://via.placeholder.com/600/92c952\"}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .getAlbums, .getPhotos, .getAlbumPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

