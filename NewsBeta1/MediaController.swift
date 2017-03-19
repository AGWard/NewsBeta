//
//  MediaController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/5/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Photos

class MediaController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate {
    
    let cellId = "cellid"
    
    
    
    lazy var cameraCollectionV: UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
       
        
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        
        
        
       return cv
        
    }()
    
    
    
    
    
    
    lazy var pictureView: UIView = {
        
       let views = UIView()
        views.backgroundColor = .white
        views.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        return views
    }()
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
   

       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        grabPhotos()
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillLayoutSubviews() {
        collectionViewConstraints()
        
        pictureViewConstraints()
    }
    
    
    
    func pictureViewConstraints() {
        
        view.addSubview(pictureView)
        
        
        pictureView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 0).isActive = true
        pictureView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        pictureView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        pictureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        

        
    }
    
    func collectionViewConstraints() {
        
        view.addSubview(cameraCollectionV)
        cameraCollectionV.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: cellId)
        
        cameraCollectionV.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        cameraCollectionV.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        cameraCollectionV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        cameraCollectionV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectionCell
        
        
        
        
        return cell
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//    
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height)
//    }
   

   
    
    var imageArray = [UIImage]()
    
    /*
    func grabPhotos() {
        
        let imageManager = PHImageManager.default()
        
        
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
                        
                        self.imageArray.append(image!)
                        
                    })
                    
                }
                
            } else {
                
                print("NO PHOTOS")
                self.cameraCollectionV.reloadData()
            }
            
        
 
        
        
        
        
    }
    */
 
}
