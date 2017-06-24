//
//  SubMainstreamCells.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/22/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class SubMainstreamCells: BaseCell {
    
    
    lazy var authorLabel: UILabel = {
        
        let authorLabel = UILabel()
        authorLabel.textColor = .gray
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        return authorLabel
    }()
    
    lazy var postedNewsImage: UIImageView = {
        
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .darkText
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
        
    }()
    
    
   lazy var postedNewsDetails: UILabel = {
        
       let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .darkText
        text.isUserInteractionEnabled = false
        text.numberOfLines = 0
        text.text = "Mainstream news story goes here"
        text.textColor = .white
        
        return text
    }()
    
    
    lazy var mainstremTimeStamp: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.text = "2days ago"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 9)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        
        return label
        
    }()


    
    
    
    override func setupViews() {
        super.setupViews()
        
        postedNewsImageConstraints()
        postedNewsDetailsCOnstraints()
        mainstreamTimestampConstraints()
        authorLabelConstraints()
        
    }
    
    
    
    
    func postedNewsImageConstraints() {
        
        addSubview(postedNewsImage)
        
        
        postedNewsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        postedNewsImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        postedNewsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 1).isActive = true
        
        
    }
    
    func postedNewsDetailsCOnstraints() {
        
        addSubview(postedNewsDetails)
        
        
        postedNewsDetails.leftAnchor.constraint(equalTo: postedNewsImage.rightAnchor, constant: 5).isActive = true
        postedNewsDetails.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        postedNewsDetails.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/4).isActive = true
        postedNewsDetails.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        
    }
    
    func mainstreamTimestampConstraints() {
        addSubview(mainstremTimeStamp)
        
        mainstremTimeStamp.leftAnchor.constraint(equalTo: postedNewsImage.rightAnchor, constant: 5).isActive = true
        mainstremTimeStamp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        mainstremTimeStamp.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5).isActive = true
        mainstremTimeStamp.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/8).isActive = true
        
    }
    
    func authorLabelConstraints() {
        
       addSubview(authorLabel)
        
        authorLabel.centerYAnchor.constraint(equalTo: mainstremTimeStamp.centerYAnchor).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2).isActive = true
        authorLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/7).isActive = true
        authorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5).isActive = true
        
        
        
    }

  

}
