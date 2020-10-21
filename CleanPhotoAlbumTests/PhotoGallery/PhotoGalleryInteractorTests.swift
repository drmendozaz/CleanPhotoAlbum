//
//  PhotoGalleryWorker.swift
//  CleanPhotoAlbumTests
//
//  Created by Daniel Mendoza Zamores on 20/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

@testable import CleanPhotoAlbum
import XCTest

class PhotoGalleryInteractorTests: XCTestCase {
    
    // MARK: - Subject Under Test (SUT)

    typealias Models = PhotoGalleryModels
    var sut: PhotoGalleryInteractor!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        setupPhotoGalleryInteractor()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Setup

    func setupPhotoGalleryInteractor() {
        sut = PhotoGalleryInteractor()
        
        
    }

    

}
