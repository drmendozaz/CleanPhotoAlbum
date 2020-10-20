//
//  PhotoGalleryViewController.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc.. All rights reserved.
//

import UIKit
import SDWebImage
import ImageViewer_swift
import SwiftSpinner

protocol PhotoGalleryDisplayLogic: class {
    func displayAlbumPhotos(viewModel: PhotoGalleryModels.FetchAlbumPhotos.ViewModel)
    func displayAlbums(viewModel: PhotoGalleryModels.FetchAlbums.ViewModel)
}

class PhotoGalleryViewController: UIViewController, PhotoGalleryDisplayLogic {
    
    // MARK: - Properties
    
    typealias Models = PhotoGalleryModels
    var router: (NSObjectProtocol & PhotoGalleryRoutingLogic & PhotoGalleryDataPassing)?
    var interactor: PhotoGalleryBusinessLogic?
    
    private var isAlbumListOpen = false
    private var images: [Models.DisplayedPhoto]?
    private var albums: Albums?
    private var imageurls: [URL]?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = PhotoGalleryInteractor()
        let presenter = PhotoGalleryPresenter()
        let router = PhotoGalleryRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchAlbums()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupView(){
        let cellNib = UINib(nibName: "ThumbnailCell", bundle: nil)
        photoCollection.register(cellNib, forCellWithReuseIdentifier: "ThumbnailCell")
        photoCollection.dataSource = self
        photoCollection.delegate = self
        let albumNib = UINib(nibName: "AlbumTableCell", bundle: nil)
        albumList.register(albumNib, forCellReuseIdentifier: "AlbumTableCell")
        albumList.dataSource = self
        albumList.delegate = self
        photoCollection.setCollectionViewLayout(GalleryFlowLayout(), animated: false)
    }
    
    // MARK: - Use Case - Fetch Album Photos
    
    @IBOutlet weak var photoCollection: UICollectionView!
    func setupFetchAlbumPhotos(albumId: String) {
        let request = Models.FetchAlbumPhotos.Request(albumId: albumId)
        interactor?.fetchAlbumPhotos(request: request)
    }
    
    func displayAlbumPhotos(viewModel: Models.FetchAlbumPhotos.ViewModel) {
        images = viewModel.photos
        imageurls = images?.compactMap({$0.url})
        photoCollection.reloadData()
        albumList.reloadData()
        SwiftSpinner.hide()
    }
    
    // MARK: - Use Case - Fetch Albums
    
    @IBOutlet weak var albumNameLbl: UILabel!
    @IBOutlet weak var albumArrow: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var albumList: UITableView!
    @IBAction func selectAlbum(_ sender: Any) {
        let screenSize = UIScreen.main.bounds.size
        let transform = isAlbumListOpen
            ?  CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        UIView.animate(withDuration: 0.25, animations: {
            self.albumArrow.transform = transform
        })
        if isAlbumListOpen {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0, usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseInOut, animations: {
                            self.albumList.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.photoCollection.frame.height)
                           }, completion: {_ in
                            self.isAlbumListOpen = false
                           })
        }else{
            
            UIView.animate(withDuration: 0.5,
                           delay: 0, usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseInOut, animations: {
                            self.albumList.frame = CGRect(x: 0, y: self.photoCollection.frame.minY, width: screenSize.width, height: self.photoCollection.frame.height)
                           }, completion: {_ in
                            self.isAlbumListOpen = true
                           })
        }
    }
    
    func setupFetchAlbums() {
        SwiftSpinner.useContainerView(photoCollection)
        SwiftSpinner.show("Loading...")
        let request = Models.FetchAlbums.Request(userId: "TBI")
        interactor?.fetchAlbums(request: request)
    }
    
    func displayAlbums(viewModel: Models.FetchAlbums.ViewModel) {
        albumNameLbl.text = viewModel.albums.first?.title.uppercased()
        albums = viewModel.albums
        setupFetchAlbumPhotos(albumId: String(viewModel.albums.first!.id) )
    }
    
}

extension PhotoGalleryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AlbumTableCell = albumList.dequeueReusableCell(withIdentifier: "AlbumTableCell", for: indexPath) as! AlbumTableCell
        cell.albumNameLbl.text = albums![indexPath.row].title
        cell.albumCountLbl.text = "\(albums!.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumNameLbl.text = albums![indexPath.row].title.uppercased()
        selectAlbum(tableView)
        SwiftSpinner.show("Loading...")
        setupFetchAlbumPhotos(albumId: String(albums![indexPath.row].id))
    }
    
}

extension PhotoGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ThumbnailCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "ThumbnailCell",
                                 for: indexPath) as! ThumbnailCell
        
        cell.imageView.sd_setImage(with: images![indexPath.item].thumbnailUrl!)
        cell.imageView.setupImageViewer(
            urls: imageurls!,
            initialIndex: indexPath.item,
            options: [
                .theme(.light),
                .rightNavItemTitle("Info", onTap: { i in
                    print("TAPPED", i)
                })
            ],
            from: self)
        
        return cell
    }
    
    
}
