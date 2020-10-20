//
//  PhotoGalleryModels.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit

enum PhotoGalleryModels {
    
    struct DisplayedPhoto {
        var albumId: Int
        var id: Int
        var title: String
        var url: URL?
        var thumbnailUrl: URL?
    }

    // MARK: - Use Cases

    enum FetchAlbumPhotos {
        struct Request {
            var albumId: String
        }

        struct Response {
            var photos: Photos
        }

        struct ViewModel {
            var photos: [DisplayedPhoto]
        }
    }
    
    enum FetchAlbums {
        struct Request {
            var userId: String
        }

        struct Response {
            var albums: Albums
        }

        struct ViewModel {
            var albums: Albums
        }
    }


}
