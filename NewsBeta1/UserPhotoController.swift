//
//  UserPhotoController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/7/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

//import UIKit
//import Photos
//
//import MobileCoreServices
//
//class UserPhotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    
//    
//    var homePage = HomeController()
//    
//    
//    
//    lazy var titleViewContainer: UIView = {
//        
//       let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
//        titleView.backgroundColor = .red
//        
//        
//        
//        return titleView
//        
//    }()
//    
//    
//    lazy var titleImage: UIImageView = {
//       
//        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
//
//        image.backgroundColor = .clear
//        image.image = UIImage(named: "video2")
//        image.contentMode = .scaleAspectFit
//        image.clipsToBounds = true
//        image.layer.masksToBounds = true
//        image.isUserInteractionEnabled = true
//        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectVideo)))
//        
//        
//        
//        return image
//        
//    }()
//    
// 
//    
//    lazy var rightBarButton: UIButton = {
//        
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
//        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
//        button.backgroundColor = .clear
//        button.setTitle("Next", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//   
//        
//        
//        return button
//        
//    }()
//
//    
//    
//    
//    
//    let selectedImageView: UIImageView = {
//       
//        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.backgroundColor = .white
//        imgView.contentMode = .scaleAspectFit
//        imgView.clipsToBounds = true
//        
//        
//        
//        
//        return imgView
//        
//    }()
//    
//    
//    
//    
//    var assetCollection: PHAssetCollection!
//    var fetchResult: PHFetchResult<PHAsset>!
//    var isAlbumFound: Bool = false
//    
//    var fetchOptions = PHFetchOptions()
//    var imageFIle = [UIImage]()
//
//
//    
//    fileprivate let imageManagerss = PHCachingImageManager()
//    
//    
//    var albumName = "Snapchat"
//    let cellID = "PhotoCellID"
// 
//    
//    lazy var collectionV: UICollectionView = {
//        
//       let layout = UICollectionViewFlowLayout()
//        
//        let views = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        views.backgroundColor = .white
//        views.translatesAutoresizingMaskIntoConstraints = false
//        views.delegate = self
//        views.dataSource = self
//        
//        
//        return views
//        
//    }()
//    
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//
//        
//        let rightButton = UIBarButtonItem(customView: rightBarButton)
//       
//        
//        navigationItem.rightBarButtonItem = rightButton
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBackToHomeScreen))
//        navigationItem.titleView = titleImage
//        
//        
//        
//
//        
//
//        
//    }
//    
//    override func viewWillLayoutSubviews() {
//        
//        collectionVConstraints()
//        selectedImageViewConstraints()
//        
//        
//        
//        
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
////        refreshPhotoView()
//        
//    }
//    
//    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//        
//        print("memory warning UserPhotoController")
//    }
//    
//
//    
//    
//    
//    func collectionVConstraints() {
//        
//        view.addSubview(collectionV)
//        collectionV.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: cellID)
//        
//        collectionV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        collectionV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionV.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
//        
//        
//    }
//    
//    var selectedViewHeight: NSLayoutConstraint?
//    var selectedViewWidth: NSLayoutConstraint?
//    
//    func selectedImageViewConstraints() {
//        
//        view.addSubview(selectedImageView)
//        
//        let height = view.bounds.height / 2
//        
//        selectedViewWidth = selectedImageView.widthAnchor.constraint(equalTo: view.widthAnchor)
//        selectedViewWidth?.isActive = true
//        selectedViewHeight = selectedImageView.heightAnchor.constraint(equalToConstant: height)
//        selectedViewHeight?.isActive = true
//        selectedImageView.bottomAnchor.constraint(equalTo: collectionV.topAnchor).isActive = true
//        
//        
//        
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(picsArray.count)
//        return picsArray.count
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoSelectionCell
//
//        
//        cell?.photoView.image = picsArray[indexPath.item]
//        
//        if indexPath.item == 0 && indexPath.section == 0 && selectedImageView.image == nil {
//        selectedImageView.image = picsArray[0]
//        
//        }
//        
//        
//        return cell!
//    
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        
//        let picSize = view.frame.width / 4 - 1
//        
//        return CGSize(width: picSize, height: picSize)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.5
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.5
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//
//    selectedImageView.image = picsArray[indexPath.item]
//        
//       print(indexPath.row)
//    }
//    
//    lazy var photoAlbumLoad: PhotoAlbumCollectionSheet = {
//        
//        let photos = PhotoAlbumCollectionSheet()
//        photos.userPhoto = self
//        
//        
//        return photos
//        
//    }()
//    
//    
//    
//    func grabPhotos() {
//        
//        print("Loading..........")
//        
//        photoAlbumLoad.fetchPhotos()
//        
//        
//        
//    }
//    
//    
//    
//    func goBackToHomeScreen() {
//        
//       
//        dismiss(animated: true, completion: nil)
//        
//        
//    }
//    
//
//    
//    var videourls: URL?
//    
//    func selectVideo() {
//        
//        
//        print("videos selected")
//        
//        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.allowsEditing = true
//            imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
//            
//            self.present(imagePicker, animated: true, completion: nil)
//            
//            
//        } else {
//            
//            print("not getting access to photo library")
//        }
//        
//        
//    }
//    
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        if let videoURL = info[UIImagePickerControllerMediaURL] as? URL{
//            
//            print(videoURL)
//            selectedImageView.image = videoPreviewImage(filename: videoURL)
//            videourls = videoURL
//
//            
//            dismiss(animated: true, completion: nil)
//            
//        }
//        
//        
//        
//
//        
//        var selectedImageFromPicker: UIImage?
//        
//        if let editImage = info [UIImagePickerControllerEditedImage] as? UIImage {
//            
//            selectedImageFromPicker = editImage
//            
//        } else if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            
//            
//            selectedImageFromPicker = chosenImage
//            
//            
//        }
//        
//        if let selectedImage = selectedImageFromPicker {
//            
//            selectedImageView.image = selectedImage
//            
//            
//            dismiss(animated: true, completion: nil)
//        }
//    
//    }
//    
//    
//    func videoPreviewImage(filename: URL) -> UIImage? {
//        
//       
//        let asset = AVURLAsset(url: filename)
//        let generator = AVAssetImageGenerator(asset: asset)
//        generator.appliesPreferredTrackTransform = true
//        
//        let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
//        
//        do {
//            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
//            return UIImage(cgImage: imageRef)
//        }
//        catch let error as NSError
//        {
//            print("Image generation failed with error \(error)")
//            return nil
//        }
//        
//        
//        
//    }
//    
//    func nextButtonPressed() {
//        
//
//        
//        let modalViewController = PostingPageController()
//        
//        modalViewController.modalTransitionStyle = .flipHorizontal
//        modalViewController.modalPresentationStyle = .overCurrentContext
//        modalViewController.selectedPic.image = selectedImageView.image
//        
//        if videourls != nil {
//            
//           modalViewController.videoImageURL = videourls!
//        }
//        
//        
//        let navController = UINavigationController(rootViewController: modalViewController)
//        
//        present(navController, animated: true, completion: nil)
//        
//    }
//
//
//    
//}
//

    

