//
//  UserPhotoController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/7/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Photos

class UserPhotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
 
    
    lazy var rightBarButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.backgroundColor = .clear
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.blue, for: .normal)
   
        
        
        return button
        
    }()

    
    
    
    
    let selectedImageView: UIImageView = {
       
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .white
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        
        
        
        
        return imgView
        
    }()
    
    
    
    
    var assetCollection: PHAssetCollection!
    var fetchResult: PHFetchResult<PHAsset>!
    var isAlbumFound: Bool = false
    var picsArray = [UIImage]()
    var fetchOptions = PHFetchOptions()
    
    fileprivate let imageManager = PHCachingImageManager()
    
    
    var albumName = "Snapchat"
    let cellID = "PhotoCellID"
 
    
    lazy var collectionV: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        
        let views = UICollectionView(frame: .zero, collectionViewLayout: layout)
        views.backgroundColor = .white
        views.translatesAutoresizingMaskIntoConstraints = false
        views.delegate = self
        views.dataSource = self
        
        
        return views
        
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rightButton = UIBarButtonItem(customView: rightBarButton)
        
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBackToHomeScreen))
        
        
        
        
//        getPhotos()
        

        
    }
    
    override func viewWillLayoutSubviews() {
        collectionVConstraints()
        selectedImageViewConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        refreshPhotoView()
        grabPhotos()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionVConstraints() {
        
        view.addSubview(collectionV)
        collectionV.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionV.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        
    }
    
    func selectedImageViewConstraints() {
        
        view.addSubview(selectedImageView)
        
        
        
        selectedImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        selectedImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        selectedImageView.bottomAnchor.constraint(equalTo: collectionV.topAnchor).isActive = true
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(picsArray.count)
        return picsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoSelectionCell
        
        
        cell?.photoView.image = picsArray[indexPath.item]
        
        if indexPath.item == 0 && indexPath.section == 0 {
           selectedImageView.image = picsArray[0]
            
            
        }
        
        
        
        
        return cell!
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let picSize = view.frame.width / 4 - 1
        
        return CGSize(width: picSize, height: picSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let image: UIImage = picsArray[indexPath.row]
        selectedImageView.image = image
        
       print(indexPath.row)
    }
    
    func grabPhotos() {
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            
            
            let imageManager = PHCachingImageManager.default()
            
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .opportunistic
            
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
            if fetchResult.count > 0 {
                
                for i in 0..<fetchResult.count {
                    
                    imageManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                        
                        image, error in
                        
                        DispatchQueue.main.async {
                            self.picsArray.append(image!)
                            self.collectionV.reloadData()
                        }
                        
                        
                        
                    })
                    
                }
                
            } else {
                
                print("NO PHOTOS")
                self.collectionV.reloadData()
                
                
                
            }
            
            
            
            
        }
        
    }
    
    
    func nextButtonPressed() {
        
        print(selectedImageView.image!)
        
        
        
        let modalViewController = PostingPageController()
        
        modalViewController.modalTransitionStyle = .flipHorizontal
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.selectedPic.image = selectedImageView.image
        
        let navController = UINavigationController(rootViewController: modalViewController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    func goBackToHomeScreen() {
        
        let homeController = HomeController()
        
        homeController.modalPresentationStyle = .overFullScreen
        
        let navController = UINavigationController(rootViewController: homeController)
        
        present(navController, animated: true, completion: nil)
        
        
    }
    
  
    
    
    
}


    
    
    
//    func getPhotos() {
//        
//        
//        
//        
//        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
//        
//        
////        self.fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        
//        let photoCollection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//        
//        
//        //DNews folder already created
//        print(photoCollection)
//        
//        if(photoCollection.firstObject != nil) {
//            
//            print("album found")
//            
//            self.isAlbumFound = true
//            self.assetCollection = photoCollection.firstObject! as PHAssetCollection
//            
//            
//            
//            
//        } else {
//            
//            //create DNewsPics folder
//            print("folder does not exist, creating now...")
//            
//            try! PHPhotoLibrary.shared().performChangesAndWait {
//                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: self.albumName)
// 
//                
//            }
//            
//
//            
//            
////            PHPhotoLibrary.shared().performChanges({
////                
////                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: self.albumName)
////                print(request)
////                
////                
////            }, completionHandler: {(succes, error) in
////                
////              
////                if succes {
////                    
////                    self.getPhotos()
////                }
////                
////                
////                
////            })
//            
//        }
//        
//        
//        
//    }
//    
//    func refreshPhotoView() {
//        
//        if self.assetCollection == nil {
//            
//            self.getPhotos()
//        }
//
//        
//        
//        self.fetchResult = PHAsset.fetchAssets(in: self.assetCollection, options: nil)
//        
//        
//        
//        
//        for i in 0..<self.fetchResult.count {
//            
//            print("here is the new fetch result count\(self.fetchResult.count)")
//            
//            let requestOptions = PHImageRequestOptions()
//            requestOptions.isSynchronous = true
//            requestOptions.deliveryMode = .opportunistic
//            
//            
//            
//            let asset = self.fetchResult.object(at: i) as PHAsset
//            self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: requestOptions, resultHandler: {(result, info) in
//                
//                
//               
//                self.picsArray.append(result!)
//                
//                
//                
//                self.collectionV.reloadData()
//                
//                
//            })
//        }
//        
//        
//     self.fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        
//    }

    
    

