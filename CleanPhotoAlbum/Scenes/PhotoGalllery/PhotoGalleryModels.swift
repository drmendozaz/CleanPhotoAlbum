//
//  PhotoGalleryModels.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit

enum PhotoGalleryModels {

    // MARK: - Use Cases

    enum FetchAlbumPhotos {
        struct Request {
            var albumId: String
        }

        struct Response {
            var photos: Photos
            var error: PhotoGalleryError?
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
            var error: PhotoGalleryError?
        }

        struct ViewModel {
            var albums: Albums
        }
    }
    
    // MARK: - Types

    typealias PhotoGalleryError = Error<PhotoGalleryErrorType>

    
    enum PhotoGalleryErrorType {
        case networkError
        case unknown
    }

    struct Error<T> {
        var type: T
        var message: String?

        init(type: T) {
            self.type = type
        }
    }

}
