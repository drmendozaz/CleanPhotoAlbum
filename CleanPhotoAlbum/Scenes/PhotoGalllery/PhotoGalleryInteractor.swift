//
//  PhotoGalleryInteractor.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit
import Moya

protocol PhotoGalleryBusinessLogic {
    func fetchAlbumPhotos(request: PhotoGalleryModels.FetchAlbumPhotos.Request)
    func fetchAlbums(request: PhotoGalleryModels.FetchAlbums.Request)
}

protocol PhotoGalleryDataStore {
    var userId: String? { get set }
}

class PhotoGalleryInteractor: PhotoGalleryBusinessLogic, PhotoGalleryDataStore {

    // MARK: - Properties

    typealias Models = PhotoGalleryModels

    lazy var worker = PhotoGalleryWorker()
    var presenter: PhotoGalleryPresentationLogic?

    var userId: String?

    // MARK: - Use Case - Fetch Album Photos
    
    func fetchAlbumPhotos(request: Models.FetchAlbumPhotos.Request){
        var response: Models.FetchAlbumPhotos.Response!
        var er: Models.PhotoGalleryError!
        
        worker.getPhotosByAlbumId(albumId: request.albumId).done{ photos in
            response = Models.FetchAlbumPhotos.Response(photos: photos)
        }.catch { error in
            switch error{
            case MoyaError.underlying( _ as NSError, _):
                er = Models.PhotoGalleryError(type: .networkError)
                er.message = error.localizedDescription
                response = Models.FetchAlbumPhotos.Response(photos: [], error: er)
            default:
                er = Models.PhotoGalleryError(type: .unknown)
                er.message = error.localizedDescription
                response = Models.FetchAlbumPhotos.Response(photos: [], error: er)
            }
        }.finally {
            self.presenter?.presentFetchAlbumPhotos(response: response)
        }
    }
    
    // MARK: - Use Case - Fetch Albums

    func fetchAlbums(request: Models.FetchAlbums.Request) {
        var response: Models.FetchAlbums.Response!
        var er: Models.PhotoGalleryError!
        
        worker.getAllAlbums().done{ albums in
            response = Models.FetchAlbums.Response(albums: albums)
        }.catch { error in
            switch error{
            case MoyaError.underlying( _ as NSError, _):
                er = Models.PhotoGalleryError(type: .networkError)
                er.message = error.localizedDescription
                response = Models.FetchAlbums.Response(albums: [], error: er)
            default:
                er = Models.PhotoGalleryError(type: .unknown)
                er.message = error.localizedDescription
                response = Models.FetchAlbums.Response(albums: [], error: er)
            }
        }.finally {
            self.presenter?.presentFetchAlbums(response: response)
        }
    }
}
