//
//  NewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/13/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

// delegate for feedpic
protocol CellSegwayDelegate: class {
    func feedPicTapped()
}



class TriniNewsCell: BaseCell {
    
    weak var delegate: CellSegwayDelegate?
    
    
    
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
    
    
    
    lazy var timeLabelContainer: UIView = {
        let pic = UIView()
        pic.translatesAutoresizingMaskIntoConstraints = false

        pic.backgroundColor = .red
        pic.alpha = 0.5
        
        return pic


    }()
    
    
    lazy var moreOptionsButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("***", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moreOptionsButtonTapped), for: .touchUpInside)

        return button

    }()
    
    
    
    let timeLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 9)
        
        return label
        
    }()
    
    
    let newsHeadingLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKING NEWS"
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    
    
    let reportNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont(name: "Avenir Next", size: 12)
        
        
        return label
    }()

    
    let storyByLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Story By:"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 10)
        
        
        return label
    }()
    
    
    let postedImageView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
       return postedView
    }()
    
    
    let postedTextView: UITextView = {
        
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
        reporterLabelConstraints()
        feedUserPicConstraints()
        timeLabelContainerConstraints()
        timeLabelConstraints()
        moreOptionsButtonConstraints()
        shareIconConstraints()
        commentIconConstraints()
        
        
        
        
    }
    
    func postedImageViewConstraints() {
        
        addSubview(postedImageView)
        
        postedImageView.topAnchor.constraint(equalTo: newsHeadingLabel.bottomAnchor, constant: 0).isActive = true
        
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
    
    func reporterLabelConstraints() {
        
        
        addSubview(reportNameLabel)
        
        
        
        
        reportNameLabel.leftAnchor.constraint(equalTo: storyByLabel.rightAnchor, constant: 2).isActive = true
        reportNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/9).isActive = true
        reportNameLabel.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
 
    }
    
    func feedUserPicConstraints() {
        
        addSubview(feedUserPic)
        
        feedUserPic.widthAnchor.constraint(equalToConstant: 20).isActive = true
        feedUserPic.heightAnchor.constraint(equalToConstant: 20).isActive = true
        feedUserPic.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        feedUserPic.leftAnchor.constraint(equalTo: reportNameLabel.rightAnchor, constant: 2).isActive = true
        
        
    }
    
    
    func storyByLabelConstraints() {
        
        addSubview(storyByLabel)
        
        storyByLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        storyByLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/8).isActive = true
        storyByLabel.topAnchor.constraint(equalTo: postedImageView.bottomAnchor, constant: 10).isActive = true
        
        
    }
    
    func newsHeadingLabelConstraints() {
        
        
        addSubview(newsHeadingLabel)
        
        newsHeadingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        newsHeadingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        newsHeadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        newsHeadingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/16).isActive = true
        
    }
    
    func timeLabelConstraints() {
        
        timeLabelContainer.addSubview(timeLabel)
        
        
        
        timeLabel.leftAnchor.constraint(equalTo: timeLabelContainer.leftAnchor, constant: 2).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: timeLabelContainer.bottomAnchor).isActive = true
        
        
        
    }
    
    
    func moreOptionsButtonConstraints() {
        
        addSubview(moreOptionsButton)
        
        
        moreOptionsButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        moreOptionsButton.centerYAnchor.constraint(equalTo: newsHeadingLabel.centerYAnchor).isActive = true
        
        
    }
    
    func timeLabelContainerConstraints() {
        
        addSubview(timeLabelContainer)
        
        timeLabelContainer.rightAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: -2).isActive = true
        timeLabelContainer.bottomAnchor.constraint(equalTo: postedImageView.bottomAnchor).isActive = true
        timeLabelContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/6).isActive = true
        timeLabelContainer.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    
    
    func shareIconConstraints() {
        
        
        addSubview(shareIconView)
        
        shareIconView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2).isActive = true
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
    
    func profilePicTapped() {
        
        
        //method below uses delegate from FeedCell
 
        
      delegate?.feedPicTapped()
        
        
        
    }

    

    
    
    func moreOptionsButtonTapped() {
        
        print("Abuse")
        
        
    }
    
    
    
}
