//
//  PhotoGalleryRouter.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit

protocol PhotoGalleryRoutingLogic {
    func routePhotoDetail()
}

protocol PhotoGalleryDataPassing {
    var dataStore: PhotoGalleryDataStore? { get }
}

class PhotoGalleryRouter: NSObject, PhotoGalleryRoutingLogic, PhotoGalleryDataPassing {

    // MARK: - Properties

    weak var viewController: PhotoGalleryViewController?
    var dataStore: PhotoGalleryDataStore?

    // MARK: - Routing

    func routePhotoDetail() {
        
        
    }

    
}
