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
}



var name: String!

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CellSegwayDelegate {
    
    
    
    var delegate: CellSegaway2Delegate?
    
    
    let cellID = "cellID"
    var arrays = [DatabaseProperties]()
    var reveredArrays = [DatabaseProperties]()
    var userID: String?
    
    
    
    var postedPhotos: [UIImage] = []
    var postedText: [String] = []
    var imageURLS: [String] = []
    var idlist = [String]()
    var reporterList = [String]()
    var userProfilePicFeed = [String]()
    var timestampArray: [String] = []
    var postArray = [String]()
    
    
    lazy var refreshData: UIRefreshControl = {
        
        
       let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(performRefreshData), for: .valueChanged)
        refresh.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        return refresh
    }()
    
    

    
   
    
    
    lazy var collectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
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
        
        if #available(iOS 10.0, *) {
            
            
            collectionViews.refreshControl = refreshData
        } else {
            
            
            collectionViews.addSubview(refreshData)
            
        }
        
        
       
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
        
        
        let newArrays = reveredArrays[indexPath.row]
        cell.postedImageView.sd_setImage(with: URL(string: newArrays.postedPicURL!))
        cell.postedTextView.text = newArrays.postedText
        cell.reportNameLabel.text = newArrays.reporterName
        cell.feedUserPic.sd_setImage(with: URL(string: newArrays.userImage!))
        
        if let headline = newArrays.newsHeadlines {
            
            cell.newsHeadingLabel.text = headline

        } else {
            
            cell.newsHeadingLabel.text = "Breaking News"
        }
        
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
        
        let ref = FIRDatabase.database().reference().child("PostedData")
        ref.observe(.childAdded, with: { (snapshot) in
            
            
           
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
            
            
            
                let dbProperties = DatabaseProperties()
                    dbProperties.setValuesForKeys(dictionary)
                
            
                    self.arrays.append(dbProperties)
                    self.reveredArrays = self.arrays.reversed()
                
                
                
                self.collectionViews.reloadData()
                
            

                
                            
        }

            
        
            
        }, withCancel: nil)
        
 
    }
    
    
    
    func performRefreshData() {
        
        getPostedData()
        collectionViews.refreshControl?.endRefreshing()
        
    }
    
    func feedPicTapped() {
        
        //method below aquires delegate from HomeController

        
        delegate?.profilePicTapped()
        
        
    }
 
 
}



