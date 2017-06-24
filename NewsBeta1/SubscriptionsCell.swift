//
//  SubscriptionsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 6/10/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class SubscriptionsCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, CellSegwayDelegate {
    
    let currentUser = Auth.auth().currentUser?.uid
    
    var delegate: CellSegaway2Delegate?
    
    
    let cellID = "cellID"
    
    
    
    var postedPhotos: [String] = []
    var postedText: [String] = []
    var newsHeadlines: [String] = []
    var imageURLS: [String] = []
    var idlist = [String]()
    var reporterList = [String]()
    var userProfilePicFeed = [String]()
    var timestampArray: [String] = []

    
    lazy var refreshControl: UIRefreshControl = {
        
       let control = UIRefreshControl()
        control.tintColor = .red
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return control
    }()
    
    
    lazy var networkRequest: NetworkingService = {
        
        let netReq = NetworkingService()
        netReq.subscrip = self
        
        
        return netReq
    }()
    
    
    
    lazy var collectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.alwaysBounceVertical = true
        
        
        return collection
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        

        collectionViewContraints()
        collectionViews.addSubview(refreshControl)
        
        
        
    }
    
    
    func collectionViewContraints() {
        
        addSubview(collectionViews)
        collectionViews.register(SubscriptionsFeedCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionViews.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        collectionViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        collectionViews.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionViews.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    
        return reveresSubscripArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SubscriptionsFeedCell
        
    
        
        if currentUser == nil {
            
            return cell
        }
        
        cell.backgroundColor = .white
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 4
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shouldRasterize = false
        cell.layer.borderColor = UIColor.gray.cgColor
        
        cell.delegate = self
        cell.subMainCell = self
        
        
        let newArrays = reveresSubscripArray[indexPath.row]
        
        cell.postedImageView.sd_setImage(with: URL(string: newArrays.postedPicURL!))
        cell.newsHeadingLabel.text = newArrays.newsHeadlines
        cell.postedNewsDetails.text = newArrays.postedText
        cell.feedUserPic.sd_setImage(with: URL(string: newArrays.userImage!))
        cell.userIdNumber.text = newArrays.userID
        cell.userName.text = newArrays.reporterName
        cell.timeID.text = newArrays.timestamp

        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        
        let dates = dateFormatter.date(from: newArrays.timeUTC!)
        cell.timeLabel.text = dates?.timeAgoDisplay()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        return CGSize(width: frame.width, height: frame.height / 4)
        
    }
    
    func shareOption(view: UIActivityViewController?, alert: UIAlertController?) {
        
        delegate?.presentShareController(viewS: view, alerts: alert)
    }
    
    
    
    
    
    
//    func getPostedData() {
//        
//        networkRequest.getPostedData(area: "subscriptionPost")
//        
//        
//    }
    
    
    func otherUserTapped(userID: String, userName: String) {
        
        //method for other users, linked in Home Controller
        
        delegate?.otherUserTapped(userID: userID, userName: userName)
        
    }
    
    
    
    
    func feedPicTapped() {
        
        //method below aquires delegate from HomeController
        
        
        delegate?.profilePicTapped()
        
        
    }
    
    @objc func refreshData() {
        
        
        collectionViews.reloadData()
        stopRefreshing()
        
    }
    
    func stopRefreshing() {
        
        refreshControl.endRefreshing()
    }
    


}
