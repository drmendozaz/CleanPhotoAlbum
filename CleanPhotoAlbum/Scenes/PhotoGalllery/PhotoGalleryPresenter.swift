//
//  PhotoGalleryPresenter.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit

protocol PhotoGalleryPresentationLogic {
    func presentFetchAlbumPhotos(response: PhotoGalleryModels.FetchAlbumPhotos.Response)
    func presentFetchAlbums(response: PhotoGalleryModels.FetchAlbums.Response)
}

class PhotoGalleryPresenter: PhotoGalleryPresentationLogic {
    
    // MARK: - Properties
    
    typealias Models = PhotoGalleryModels
    weak var viewController: PhotoGalleryDisplayLogic?
    
    // MARK: - Use Case - Fetch Album Photos
    
    func presentFetchAlbumPhotos(response: Models.FetchAlbumPhotos.Response){
        let photos = response.photos.map({ Models.DisplayedPhoto(albumId: $0.albumId, id: $0.id, title: $0.title, url: URL(string: $0.url), thumbnailUrl: URL(string:$0.thumbnailUrl)) })
        let viewModel = Models.FetchAlbumPhotos.ViewModel(photos: photos)
        
        viewController?.displayAlbumPhotos(viewModel: viewModel)
    }
    
    // MARK: - Use Case - Fetch Albums

    func presentFetchAlbums(response: Models.FetchAlbums.Response) {
        
        let albums = response.albums
        let viewModel = Models.FetchAlbums.ViewModel(albums: albums)
        viewController?.displayAlbums(viewModel: viewModel)
    }
}
