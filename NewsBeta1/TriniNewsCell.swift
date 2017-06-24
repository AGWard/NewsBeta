//
//  NewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/13/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

// delegate for feedpic
protocol CellSegwayDelegate: class {
    func feedPicTapped()
    func otherUserTapped(userID: String, userName: String)
    func shareOption(view: UIActivityViewController?, alert: UIAlertController?)
}




class TriniNewsCell: BaseCell {
    
    weak var delegate: CellSegwayDelegate?
    
    var feedCell: FeedCell?
    var dataBaseCells: DatabaseProperties?


    
    let currentID = Auth.auth().currentUser?.uid
    
    let abuseList: [MenuList] = [MenuList(name: "Inappropriate Photo", imageName: "report"), MenuList(name: "Photo Rights", imageName: "photoRights2"), MenuList(name: "Hate Speech", imageName: "hateSpeech"), MenuList(name: "Cancel", imageName: "cancel")]
    
    let menuList1: [MenuList] = {
        
        return [MenuList(name: "Report Abuse", imageName: "report"), MenuList(name: "Subscribe", imageName: "subscriptions"), MenuList(name: "Comment", imageName: "comment"), MenuList(name: "Share", imageName: "shareArrow"), MenuList(name: "Cancel", imageName: "cancel")]
    }()

    
    lazy var netRequest: NetworkingService = {
       
        let request = NetworkingService()
        request.trinicell = self
        
        return request
    }()
    
    
    lazy var readCounter: UILabel = {
        
       let counter = UILabel()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.textColor = .black
        counter.font = UIFont.boldSystemFont(ofSize: 10)
       
        return counter
    }()
    
    
    lazy var timeID: UILabel = {
        
        let label = UILabel()
        
        
        return label
    }()

    lazy var userID: UILabel = {
        
        let label = UILabel()
        
        
        return label
    }()
    

    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        
        return indicator
        
    }()

    
    
    
    lazy var playButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "newPlayButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)

        
        
        
       return button
        
    }()
    
    
    
    
    lazy var readIcon: UIImageView = {
        
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.layer.cornerRadius = 0.5 * 30
        pic.clipsToBounds = true
        pic.image = UIImage(named: "check")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(unreadTapped)))
        pic.isHidden = true
        
        
        return pic
 
        
    }()
    
    
    
    lazy var unreadIcon: UIImageView = {
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.layer.cornerRadius = 0.5 * 30
        pic.clipsToBounds = true
        pic.image = UIImage(named: "shareArrow")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        pic.isHidden = true
        
        return pic


    }()
    
    
    
    lazy var timeLabelContainer: UIImageView = {
        
        let pic = UIImageView()
        pic.image = UIImage(named: "label")
        pic.contentMode = .scaleAspectFill
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.clipsToBounds = true
    
        
        return pic


    }()
    
    
    
    
    lazy var moreOptionsButton: UIImageView = {
        
        let button = UIImageView()
        
        button.image = UIImage(named: "moreOptions")
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moreOptionsButtonTapped)))
        button.translatesAutoresizingMaskIntoConstraints = false

        return button

    }()
    
    
    
    lazy var timeLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 10)

        
        return label
        
    }()
    
    
    lazy var newsHeadingLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKING NEWS"
        label.textColor = .black
        label.font = UIFont(name: "Baskerville", size: 18)
        label.textAlignment = .left
        
        
        return label
        

        
    }()
    
    
    
    lazy var feedUserPic: UIImageView = {
        
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
//        pic.layer.cornerRadius = 0.5 * 20
        //        pic.layer.borderWidth = 2
        //        pic.layer.borderColor = UIColor.red.cgColor
        pic.clipsToBounds = true
        pic.image = UIImage(named: "default")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
        return pic
    }()
    
    
    
    lazy var reportNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont(name: "Avenir Next", size: 12)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        return label
    }()

    
    lazy var storyByLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Story By:"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 10)
        
        
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
        tap.addTarget(self, action: #selector(doubleTapped))
        postedView.addGestureRecognizer(tap)
       
        
        
       return postedView
    }()
    
    
    lazy var postedTextView: UITextView = {
        
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.backgroundColor = .white
        field.autocorrectionType = .yes
        field.autocapitalizationType = .sentences
        field.isUserInteractionEnabled = false
        
        
        return field
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        
        
        newsHeadingLabelConstraints()
        
        postedImageViewConstraints()
        storyByLabelConstraints()
        postedTextViewConstraints()
        feedUserPicConstraints()
        reporterLabelConstraints()
        timeLabelContainerConstraints()
        timeLabelConstraints()
        moreOptionsButtonConstraints()
        readCounterConstraints()
        readIconConstraints()
        playButtonConstraints()
        activityIndicatorConstraints()
        
        
        
        
        
        
    }
    
    func postedImageViewConstraints() {
        
        addSubview(postedImageView)
        
        postedImageView.topAnchor.constraint(equalTo: newsHeadingLabel.bottomAnchor, constant: 10).isActive = true
        
        postedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        postedImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/5).isActive = true
        
        
    }
    
    
    func postedTextViewConstraints() {
        
        addSubview(postedTextView)
        
        postedTextView.topAnchor.constraint(equalTo: storyByLabel.bottomAnchor, constant: 10).isActive = true
        postedTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        postedTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        postedTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        
   
        
        
    }
    
    func feedUserPicConstraints() {
        
        addSubview(feedUserPic)
        
        feedUserPic.widthAnchor.constraint(equalToConstant: 20).isActive = true
        feedUserPic.heightAnchor.constraint(equalToConstant: 20).isActive = true
        feedUserPic.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        feedUserPic.leftAnchor.constraint(equalTo: storyByLabel.rightAnchor, constant: 2).isActive = true
        
        
    }

    
    func reporterLabelConstraints() {
        
        
        addSubview(reportNameLabel)
        
        
        
        
        reportNameLabel.leftAnchor.constraint(equalTo: feedUserPic.rightAnchor, constant: 2).isActive = true
        reportNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5).isActive = true
        reportNameLabel.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
 
    }
    
    
    
    func storyByLabelConstraints() {
        
        addSubview(storyByLabel)
        
        storyByLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        storyByLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/8).isActive = true
        storyByLabel.topAnchor.constraint(equalTo: postedImageView.bottomAnchor, constant: 10).isActive = true
        
        
    }
    
    func newsHeadingLabelConstraints() {
        
        
        addSubview(newsHeadingLabel)
        
        newsHeadingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        newsHeadingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        newsHeadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        newsHeadingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/16).isActive = true
        
    }
    
    func timeLabelConstraints() {
        
        timeLabelContainer.addSubview(timeLabel)
        
        
        
        timeLabel.leftAnchor.constraint(equalTo: timeLabelContainer.leftAnchor, constant: 6).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeLabelContainer.centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: timeLabelContainer.widthAnchor).isActive = true
        
        
    }
    
    
    func moreOptionsButtonConstraints() {
        
        addSubview(moreOptionsButton)
        
        
        moreOptionsButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        moreOptionsButton.centerYAnchor.constraint(equalTo: newsHeadingLabel.centerYAnchor).isActive = true
        moreOptionsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/16).isActive = true
        moreOptionsButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/16).isActive = true
        
        
    }
    
    func timeLabelContainerConstraints() {
        
        addSubview(timeLabelContainer)
        
        timeLabelContainer.rightAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 12).isActive = true
        timeLabelContainer.topAnchor.constraint(equalTo: postedImageView.topAnchor).isActive = true
        timeLabelContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/4).isActive = true
        timeLabelContainer.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/18).isActive = true
        
        
    }
    
    
    
    func unreadIconConstraints() {
        
        
//        addSubview(unreadIcon)
//        
//        unreadIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
//        unreadIcon.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
//        unreadIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/17).isActive = true
//        unreadIcon.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/17).isActive = true
        
        
    }
    
    func readCounterConstraints() {
        
        addSubview(readCounter)
        
        readCounter.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        readCounter.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        readCounter.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/6).isActive = true
        readCounter.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/14).isActive = true
        
        
        
    }

    
    
    
    func readIconConstraints() {
        
        
        addSubview(readIcon)
        
        readIcon.rightAnchor.constraint(equalTo: readCounter.leftAnchor, constant: -5).isActive = true
        readIcon.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        readIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/15).isActive = true
        readIcon.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/16).isActive = true
        
        
    }
    
    
    
    func playButtonConstraints() {
        
        
        postedImageView.addSubview(playButton)
        
        playButton.centerYAnchor.constraint(equalTo: postedImageView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: postedImageView.centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    func activityIndicatorConstraints() {
        
        postedImageView.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: postedImageView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: postedImageView.centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    

    
    
    lazy var moreOptionsView: MoreOptionsView = {
        
       let options = MoreOptionsView(menuList: self.menuList1)
        options.triniNewsCell = self
        
        
        return options
    }()
    
    lazy var abuseOptions: MoreOptionsView = {
        
        let options = MoreOptionsView(menuList: self.abuseList)
        options.triniNewsCell = self
        
        
        return options
    }()
    
    
    
    @objc func profilePicTapped() {
        
        
        guard let id = dataBaseCells?.userID else {
            
            print("no ID number detected")
            return
            
        }
        
        if id == currentID {
            
            //if true send user via delegate to userHome Page
            goToUserMenu()
            
        } else {
            
            //if not current user then view profile without access
            
            self.delegate?.otherUserTapped(userID: (dataBaseCells?.userID!)!, userName: (dataBaseCells?.reporterName!)!)
            
        }
        
        
        
    }
    
    
    func shareOptionsTapped(view: UIActivityViewController?, alert: UIAlertController?) {
        
        
        self.delegate?.shareOption(view: view, alert: alert)

        
    }
    
    

    
    func goToUserMenu() {
        
        self.delegate?.feedPicTapped()
    
        
    }
    

    
    @objc func moreOptionsButtonTapped() {
        
        moreOptionsView.showOptions(image: postedImageView.image!, headline: newsHeadingLabel.text!, userName: userID.text!, screen: true)
        
        
    }
    
    
    @objc func doubleTapped(tap: UITapGestureRecognizer) {
        
        guard let user = timeID.text else { return }
        
        if readIcon.isHidden == true {
            
            readIcon.isHidden = false
            netRequest.readPost(userID: user)

        }
        
        
 
    }
    
    
    @objc func unreadTapped() {
        
        guard let user = timeID.text else { return }
        readIcon.isHidden = true
        netRequest.unreadPost(userId: user)
        
    }

    

    
//    func zoomImage(tapGesture: UITapGestureRecognizer) {
//        
//        if dataBaseCells?.postedVideoURL != "NoVids" {
//            
//            return
//        }
//        
//        
//        if let imageView = tapGesture.view as? UIImageView {
//            
//            self.feedCell?.performStartZoomInForImage(imageView: imageView)
//            
//        }
//    
//        
//        
//        
//    }
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    
    
    @objc func playVideo() {
    
        
        
        if let videoURLString = dataBaseCells?.postedVideoURL {
            
            if videoURLString != "NoVids" {
                
                let url = URL(string: (dataBaseCells?.postedVideoURL)!)
                
                player = AVPlayer(url: url!)
                
    
                playerLayer = AVPlayerLayer(player: player)
                playerLayer?.frame = postedImageView.bounds
                postedImageView.layer.addSublayer(playerLayer!)
                
                
                player?.play()
                activityIndicator.startAnimating()
                playButton.isHidden = true
                loopVideo(videoPlayer: player!)

                
                 print("attempt to play video")
                
            }
            
        }
        
        
        
    }
    
    
    func loopVideo(videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: kCMTimeZero)
            videoPlayer.play()
        }
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicator.stopAnimating()
        playButton.isHidden = false
        
        
    }
    
    func postAbuseReport(abuseID: String) {
        
        netRequest.postAbuseReport(byUser: currentID!, postID: timeID.text!, abuseDetails: abuseID)
        
        
    }
    
    
    func showAbuseOptions() {
    
        abuseOptions.showOptions(image: nil, headline: nil, userName: nil, screen: nil)
        

        
    }
    
    
    
}
