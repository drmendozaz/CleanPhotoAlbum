//
//  PhotoGalleryWorker.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit
import PromiseKit

class PhotoGalleryWorker {

    // MARK: - Properties

    typealias Models = PhotoGalleryModels

    // MARK: - Methods
    
    func getAllAlbums() -> Promise<Albums>{
        return JPHManager.callApi(JPHService.getAlbums, dataReturnType: Albums.self)
    }
    
    func getPhotosByAlbumId(albumId: String) -> Promise<Photos>{
        return JPHManager.callApi(JPHService.getAlbumPhotos(albumId: albumId), dataReturnType: Photos.self)
    }
    
    func getAllPhotos() -> Promise<Photos>{
        return JPHManager.callApi(JPHService.getPhotos, dataReturnType: Photos.self)
    }

}
