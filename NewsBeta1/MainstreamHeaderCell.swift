//
//  MainstreamHeaderCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/23/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class MainstreamHeaderCell: BaseCell {

    var newsHeadlineImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "captures")
        
        return image
        
        
    }()
    
    var newsHeadlineDetail: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = .gray
        label.numberOfLines = 0
        label.text = "MainStream news headlines should go here and should be larger"
        label.textColor = .red
        
        
        return label
        
    }()
    
    
    var newsHeadlineTimestamp: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.text = "1min ago"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 9)
        label.textAlignment = .center
        
        return label
        
    }()
    

    override func setupViews() {
        super.setupViews()
        
        newsHeadlineImageConstraints()
        newsHeadlineDetailConstraints()
        newsHeadlineTimestampConstraints()
    }
    
    
    
    func newsHeadlineImageConstraints() {
        
        
        addSubview(newsHeadlineImage)
        
        
        newsHeadlineImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        newsHeadlineImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        newsHeadlineImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/3).isActive = true
        
        
    }
    
    func newsHeadlineDetailConstraints() {
        
        addSubview(newsHeadlineDetail)
        
        newsHeadlineDetail.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        newsHeadlineDetail.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        newsHeadlineDetail.topAnchor.constraint(equalTo: newsHeadlineImage.bottomAnchor, constant: 10).isActive = true
        newsHeadlineDetail.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.20).isActive = true
        
    }
    
    func newsHeadlineTimestampConstraints() {
        
        addSubview(newsHeadlineTimestamp)
        
        newsHeadlineTimestamp.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        newsHeadlineTimestamp.centerYAnchor.constraint(equalTo: newsHeadlineImage.bottomAnchor, constant: 0).isActive = true
        newsHeadlineTimestamp.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/6).isActive = true
        newsHeadlineTimestamp.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/12).isActive = true
        
    }
    
    

}
