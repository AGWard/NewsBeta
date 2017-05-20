//
//  FeedCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/19/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase


protocol CellSegaway2Delegate {
    func profilePicTapped()
    func otherUserTapped(userID: String, userName: String)
}

var reveredArrays = [DatabaseProperties]()
var name: String!

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CellSegwayDelegate {
    
    
    
    var delegate: CellSegaway2Delegate?
    
    
    let cellID = "cellID"
    var arrays = [DatabaseProperties]()

    
    
    
    var postedPhotos: [UIImage] = []
    var postedText: [String] = []
    var imageURLS: [String] = []
    var idlist = [String]()
    var reporterList = [String]()
    var userProfilePicFeed = [String]()
    var timestampArray: [String] = []
    var postArray = [String]()
    

    
    lazy var collectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.5
                
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .black
        collection.dataSource = self
        collection.delegate = self
        
        
        return collection
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        getPostedData()
        collectionViewContraints()
        

        
       
    }
    
    
    
    
    func collectionViewContraints() {
        
        addSubview(collectionViews)
        collectionViews.register(TriniNewsCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionViews.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        collectionViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        collectionViews.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionViews.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return reveredArrays.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TriniNewsCell
        
        
        cell.backgroundColor = .white
        
        cell.delegate = self
        cell.feedCell = self
        

        
        let newArrays = reveredArrays[indexPath.row]
        

        cell.dataBaseCells = newArrays
        
        cell.playButton.isHidden = newArrays.postedVideoURL == "NoVids"
        
        
        cell.postedImageView.sd_setImage(with: URL(string: newArrays.postedPicURL!))
        cell.postedTextView.text = newArrays.postedText
        cell.reportNameLabel.text = newArrays.reporterName
        cell.feedUserPic.sd_setImage(with: URL(string: newArrays.userImage!))
        cell.newsHeadingLabel.text = newArrays.newsHeadlines

       
  
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        
        let dates = dateFormatter.date(from: newArrays.timeUTC!)
        cell.timeLabel.text = dates?.timeAgoDisplay()

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let height = (frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: frame.width, height: height + 16 + 88)
        
        return CGSize(width: frame.width, height: frame.height / 1.2)
        
    }
    

    

    
    func getPostedData() {
        
        let ref = Database.database().reference().child("PostedData")
        ref.observe(.childAdded, with: { (snapshot) in
            
    
            if let dictionary = snapshot.value as? [String: AnyObject] {
            
            
            
                let dbProperties = DatabaseProperties()
                    dbProperties.setValuesForKeys(dictionary)
                
              
            
                    self.arrays.append(dbProperties)
//                        reveredArrays.insert(dbProperties, at: 0)
                    reveredArrays = self.arrays.reversed()
                
                
                
                self.collectionViews.reloadData()
                            
        }

            
        }, withCancel: nil)

 
    }
    

    func otherUserTapped(userID: String, userName: String) {
        
        //method for other users, linked in Home Controller
        
        delegate?.otherUserTapped(userID: userID, userName: userName)
        
    }
    
    
    
    
    func feedPicTapped() {
        
        //method below aquires delegate from HomeController

        
        delegate?.profilePicTapped()
        
        
    }
    
//    var startingFrame: CGRect?
//    var blackBackgroundView: UIView?
    
    
//    func performStartZoomInForImage(imageView: UIImageView) {
//        
//        
//        
//        
//        startingFrame = imageView.superview?.convert(imageView.frame, to: nil)
//        
//        
//        let zoomingView = UIImageView(frame: startingFrame!)
//        zoomingView.backgroundColor = .red
//        zoomingView.image = imageView.image
//        zoomingView.isUserInteractionEnabled = true
//        
//        zoomingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
//        
//        if let keyWindow = UIApplication.shared.keyWindow {
//            
//            blackBackgroundView = UIView(frame: keyWindow.frame)
//            blackBackgroundView?.backgroundColor = .black
//            blackBackgroundView?.alpha = 0
//            
//            keyWindow.addSubview(blackBackgroundView!)
//            keyWindow.addSubview(zoomingView)
//            
//            
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//                
//                self.blackBackgroundView?.alpha = 1
//                
//                zoomingView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: (self.startingFrame!.height))
//                zoomingView.center = keyWindow.center
//
//                
//                
//                
//            }, completion: nil)
//            
//   
//            
//        }
//        
//    }
//    
//    
//    func handleZoomOut(tapGesture: UITapGestureRecognizer) {
//        
//        if let zoomOutImage = tapGesture.view {
//            
//            
//            
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//                
//                
//                zoomOutImage.frame = self.startingFrame!
//                self.blackBackgroundView?.alpha = 0
//                
//                
//                
//            }, completion: { (completed: Bool) in
//                
//                
//                zoomOutImage.removeFromSuperview()
//            })
//            
//
//            
//            
//        }
//        
//        
//        
//    }
//    

 
}



