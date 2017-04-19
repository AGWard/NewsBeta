//
//  NewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/13/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class TriniNewsCell: BaseCell {
    
    
    let timeLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: "Avenir Next", size: 10)
        
        return label
        
    }()
    
    
    let newsHeadingLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKING NEWS"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        
        return label
        

        
    }()
    
    
    
    lazy var feedUserPic: UIImageView = {
        
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.layer.cornerRadius = 0.5 * 30
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
        label.font = UIFont(name: "Avenir Next", size: 14)
        
        
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
        field.isEditable = false
        
        
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
        timeLabelConstraints()
        
        
        
    }
    
    func postedImageViewConstraints() {
        
        addSubview(postedImageView)
        
        postedImageView.topAnchor.constraint(equalTo: newsHeadingLabel.bottomAnchor, constant: 0).isActive = true
        
        postedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        postedImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        
        
    }
    
    
    func postedTextViewConstraints() {
        
        addSubview(postedTextView)
        
        postedTextView.topAnchor.constraint(equalTo: storyByLabel.bottomAnchor, constant: 2).isActive = true
        postedTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4/8).isActive = true
        postedTextView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/4).isActive = true
        postedTextView.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 2).isActive = true
        
   
        
        
    }
    
    func reporterLabelConstraints() {
        
        
        addSubview(reportNameLabel)
        
        
        
        
        reportNameLabel.leftAnchor.constraint(equalTo: storyByLabel.rightAnchor, constant: 2).isActive = true
        reportNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/8).isActive = true
        reportNameLabel.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
 
    }
    
    func feedUserPicConstraints() {
        
        addSubview(feedUserPic)
        
        feedUserPic.widthAnchor.constraint(equalToConstant: 30).isActive = true
        feedUserPic.heightAnchor.constraint(equalToConstant: 30).isActive = true
        feedUserPic.centerYAnchor.constraint(equalTo: storyByLabel.centerYAnchor).isActive = true
        feedUserPic.leftAnchor.constraint(equalTo: reportNameLabel.rightAnchor, constant: 2).isActive = true
        
        
    }
    
    
    func storyByLabelConstraints() {
        
        addSubview(storyByLabel)
        
        storyByLabel.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 2).isActive = true
        storyByLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/8).isActive = true
        storyByLabel.topAnchor.constraint(equalTo: newsHeadingLabel.bottomAnchor, constant: 4).isActive = true
        
        
    }
    
    func newsHeadingLabelConstraints() {
        
        
        addSubview(newsHeadingLabel)
        
        newsHeadingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        newsHeadingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        newsHeadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        newsHeadingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/8).isActive = true
        
    }
    
    func timeLabelConstraints() {
        
        
        addSubview(timeLabel)
        
        timeLabel.topAnchor.constraint(equalTo: postedImageView.bottomAnchor, constant: 2).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        
        
        
    }
    
    
    
    func profilePicTapped() {
        
        let userHome = UserHomePageController()
        userHome.modalPresentationStyle = .pageSheet
        
        let navC = UINavigationController(rootViewController: userHome)
        
        self.window?.rootViewController?.present(navC, animated: true, completion: nil)
        
        
        
    }
    
    
    
}
