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
}


var numberOfViews = 0

class TriniNewsCell: BaseCell {
    
    weak var delegate: CellSegwayDelegate?
    
    var feedCell: FeedCell?
    var dataBaseCells: DatabaseProperties?
    
    
    
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        
        return indicator
        
    }()

    
    
    
    lazy var playButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "newPlayButton")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        button.tintColor = .red
        
        
        
       return button
        
    }()
    
    
    
    
    lazy var commentIcon: UIImageView = {
        
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.layer.cornerRadius = 0.5 * 30
        pic.clipsToBounds = true
        pic.image = UIImage(named: "comments1")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
       
        
        
        return pic
 
        
    }()
    
    
    
    lazy var shareIconView: UIImageView = {
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.layer.cornerRadius = 0.5 * 30
        pic.clipsToBounds = true
        pic.image = UIImage(named: "share")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
        return pic


    }()
    
    
    
    lazy var timeLabelContainer: UIImageView = {
        
        let pic = UIImageView()
        pic.image = UIImage(named: "label")?.withRenderingMode(.alwaysTemplate)
        pic.tintColor = .red
        pic.contentMode = .scaleAspectFill
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.clipsToBounds = true
    
        
        return pic


    }()
    
    
    
    
    lazy var moreOptionsButton: UIImageView = {
        
        let button = UIImageView()
        
        button.image = UIImage(named: "moreOptions")?.withRenderingMode(.alwaysTemplate)
        button.contentMode = .scaleAspectFit
        button.tintColor = .black
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
        postedView.contentMode = .scaleAspectFit
        postedView.clipsToBounds = true
        postedView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 3
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
        shareIconConstraints()
        commentIconConstraints()
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
    
    
    
    func shareIconConstraints() {
        
        
        addSubview(shareIconView)
        
        shareIconView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        shareIconView.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        shareIconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        shareIconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    
    
    func commentIconConstraints() {
        
        
        addSubview(commentIcon)
        
        commentIcon.rightAnchor.constraint(equalTo: shareIconView.leftAnchor, constant: -8).isActive = true
        commentIcon.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        commentIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        commentIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    
    
    func playButtonConstraints() {
        
        
        postedImageView.addSubview(playButton)
        
        playButton.centerYAnchor.constraint(equalTo: postedImageView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: postedImageView.centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    func activityIndicatorConstraints() {
        
        postedImageView.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: postedImageView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: postedImageView.centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    lazy var moreOptionsView: MoreOptionsView = {
        
       let options = MoreOptionsView()
        options.triniNewsCell = self
        
        
        return options
    }()
    
    
    func profilePicTapped() {
        
        
        guard let id = dataBaseCells?.userID else {
            
            print("no ID number detected")
            return
            
        }
        
        if id == Auth.auth().currentUser?.uid {
            
            //if true send user via delegate to userHome Page
            goToUserMenu()
            
        } else {
            
            //if not current user then view profile without access
            
            self.delegate?.otherUserTapped(userID: (dataBaseCells?.userID!)!, userName: (dataBaseCells?.reporterName!)!)
            
        }
        
        
        
    }
    
    
    func goToUserMenu() {
        
        self.delegate?.feedPicTapped()
    
        
    }
    

    
    func moreOptionsButtonTapped() {
        
        moreOptionsView.showOptions()
        
        
    }
    
    
    func doubleTapped(tap: UITapGestureRecognizer) {
        
        numberOfViews += 1
        
        print(numberOfViews)
        
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
    
    
    func playVideo() {
    
        
        
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
                
                 print("attempt to play video")
                
            }
            
        }
        
        
        
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicator.stopAnimating()
        playButton.isHidden = false
        
        
    }
    
    
    
}
