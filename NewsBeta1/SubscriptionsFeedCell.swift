//
//  SubscriptionsFeedCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 6/10/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class SubscriptionsFeedCell: BaseCell {
    
    var subMainCell: SubscriptionsCell?
    weak var delegate: CellSegwayDelegate?
    let currentID = Auth.auth().currentUser?.uid
    var dbProp: DatabaseProperties?
    
    
    lazy var netRequest: NetworkingService = {
        
        let request = NetworkingService()
        request.subscripFeed = self
        
        return request
    }()
    
    
    let abuseList: [MenuList] = [MenuList(name: "Not Appropriate", imageName: "report"), MenuList(name: "Photo Rights!", imageName: "subscriptions"), MenuList(name: "Hate Speech!", imageName: "comment"), MenuList(name: "Cancel", imageName: "subscriptions")]

    let menuList1: [MenuList] = {
        
        return [MenuList(name: "Report!", imageName: "report"), MenuList(name: "Un-Subscribe", imageName: "subscriptions"), MenuList(name: "Comment", imageName: "comment"), MenuList(name: "Share", imageName: "shareArrow"), MenuList(name: "Cancel", imageName: "cancel")]
    }()
    
    lazy var moreOptionsView: MoreOptionsView = {
        
        let options = MoreOptionsView(menuList: self.menuList1)
        options.subscripPage = self
        
        
        return options
    }()
    
    lazy var abuseOptions: MoreOptionsView = {
        
        let options = MoreOptionsView(menuList: self.abuseList)
        options.subscripPage = self
        
        
        return options
    }()


    lazy var userIdNumber: UILabel = {
        
       let label = UILabel()
        
        return label
    }()
    
    lazy var userName: UILabel = {
        
        let label = UILabel()
        
        return label
        
    }()
    
    lazy var timeID: UILabel = {
        
        let label = UILabel()
        
        
        return label
    }()


    lazy var subOptionsButton: UIImageView = {
        
       let button = UIImageView()
        button.image = UIImage(named: "optionsClear")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moreOptions)))
        
        
        return button
    }()
    
    
    lazy var timeLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 8)
        label.backgroundColor = .black
        
        
        return label
        
    }()
    
    lazy var feedUserPic: UIImageView = {
        
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.clipsToBounds = true
        pic.layer.cornerRadius = 0.5 * 25
        pic.image = UIImage(named: "default")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
        return pic
    }()

    
    lazy var postedNewsDetails: UITextView = {
        
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.textColor = .lightGray
   
        return textView
    }()


    lazy var newsHeadingLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKING NEWS"
        label.textColor = .black
        label.font = UIFont(name: "Baskerville", size: 12)
        label.textAlignment = .left
        
        
        return label
        
        
        
    }()
    
    
    lazy var postedImageView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        postedView.isUserInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 2
//        tap.addTarget(self, action: #selector(doubleTapped))
        postedView.addGestureRecognizer(tap)
        
        
        
        return postedView
    }()

    


 
    override func setupViews() {
        
        addConstraints()
        
    }

    func addConstraints() {
        
        addSubview(postedImageView)
        addSubview(newsHeadingLabel)
        addSubview(postedNewsDetails)
        addSubview(feedUserPic)
        addSubview(timeLabel)
        addSubview(subOptionsButton)
        
        
        postedImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        postedImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        postedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        
        newsHeadingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        newsHeadingLabel.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 5).isActive = true
        newsHeadingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/8).isActive = true
        newsHeadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        
        postedNewsDetails.topAnchor.constraint(equalTo: newsHeadingLabel.bottomAnchor, constant: 2).isActive = true
        postedNewsDetails.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/5).isActive = true
        postedNewsDetails.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 5).isActive = true
        postedNewsDetails.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5).isActive = true

        feedUserPic.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        feedUserPic.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 5).isActive = true
        feedUserPic.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/6).isActive = true
        feedUserPic.topAnchor.constraint(equalTo: postedNewsDetails.bottomAnchor, constant: 2).isActive = true
        
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/8).isActive = true
        
        subOptionsButton.leftAnchor.constraint(equalTo: feedUserPic.rightAnchor, constant: 25).isActive = true
        subOptionsButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/5).isActive = true
        subOptionsButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/9).isActive = true
        subOptionsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    @objc func profilePicTapped() {
        
        
        
        guard let id = userIdNumber.text else {
            
            print("no ID number detected")
            return
            
        }
        
        if id == currentID {
            
            //if true send user via delegate to userHome Page
            goToUserMenu()
            
        } else {
            
            //if not current user then view profile without access
            
            self.delegate?.otherUserTapped(userID: id, userName: userName.text!)
            
        }
        
        
        
    }

    
    
    func goToUserMenu() {
        
        self.delegate?.feedPicTapped()
        
    }
    
    @objc func moreOptions() {

        moreOptionsView.showOptions(image: postedImageView.image!, headline: newsHeadingLabel.text!, userName: userIdNumber.text!, screen: false)
        
    }
    
    
    func shareOptionsTapped(view: UIActivityViewController?, alert: UIAlertController?) {
        
        
        self.delegate?.shareOption(view: view, alert: alert)
        
        
    }
    
    
    func postAbuseReport(abuseID: String) {
        
        netRequest.postAbuseReport(byUser: currentID!, postID: timeID.text!, abuseDetails: abuseID)
        
        
    }

    
    
    func showAbuseOptions() {
        
        abuseOptions.showOptions(image: nil, headline: nil, userName: nil, screen: nil)
        
        
        
    }




}
