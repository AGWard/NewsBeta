//
//  PhotoAlbumCollection.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/23/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

//import Foundation
//import UIKit
//import Photos
//
//var picsArray = [UIImage]()
//
//class PhotoAlbumCollectionSheet {
//    
//    var userPhoto = UserPhotoController()
//    
//    
//    var imageManager: PHImageManager {
//        
//        return PHCachingImageManager.default()
//    }
//    
//    var requestOptions: PHImageRequestOptions {
//        let request = PHImageRequestOptions()
//        request.isSynchronous = true
//        request.deliveryMode = .highQualityFormat
//        return request
//        
//    }
//    
//    
//    var fetchOptions: PHFetchOptions {
//        
//        let fetch = PHFetchOptions()
//        fetch.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        
//        return fetch
//    }
//    
//    var fetchResult: PHFetchResult<PHAsset> {
//        return PHAsset.fetchAssets(with: .image, options: fetchOptions) 
//    }
//    
//    
//    func fetchPhotos() {
//        
//        
//        if fetchResult.count > 0 {
//            
//            
//            for i in 0..<fetchResult.count {
//                
//                
//                imageManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
//                    
//                    DispatchQueue.global(qos: .userInitiated).async {
//                        DispatchQueue.main.async {
//                            
//                            picsArray.append(image!)
//                            
//                            self.userPhoto.collectionV.reloadData()
//
//                            
//                        }
//                    }
//                    
//                    
//                })
//                
//                
//            }
//
//            
//        } else {
//            
//              print("NO PHOTOS")
//            self.userPhoto.collectionV.reloadData()
//            
//            
//        }
//        
//        
//    }
//    
//
//    
//    
//}
