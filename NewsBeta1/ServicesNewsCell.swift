//
//  ServicesNewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/26/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class ServicesNewsCell: BaseCell {
    
    var servicePostedNewsImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .darkText
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "news4")
        
        return image
        
    }()
    
    
    var servicePostedNewsDetails: UILabel = {
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .darkText
        text.isUserInteractionEnabled = false
        text.numberOfLines = 0
        text.text = "Mainstream news story goes here"
        text.textColor = .white
        
        return text
    }()
    
    
    var serviceMainstremTimeStamp: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.text = "2days ago"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 9)
        label.textAlignment = .center
        
        return label
        
    }()

    
    
    
    
    override func setupViews() {
        
        servicePostedNewsImageConstraints()
        servicePostedNewsDetailsCOnstraints()
        serviceMainstreamTimestampConstraints()
        
        
    }
    
    
    func servicePostedNewsImageConstraints() {
        
        addSubview(servicePostedNewsImage)
        
        
        servicePostedNewsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        servicePostedNewsImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        servicePostedNewsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 1).isActive = true
        
        
    }
    
    func servicePostedNewsDetailsCOnstraints() {
        
        addSubview(servicePostedNewsDetails)
        
        
        servicePostedNewsDetails.leftAnchor.constraint(equalTo: servicePostedNewsImage.rightAnchor, constant: 5).isActive = true
        servicePostedNewsDetails.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        servicePostedNewsDetails.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        servicePostedNewsDetails.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        
    }
    
    func serviceMainstreamTimestampConstraints() {
        
        addSubview(serviceMainstremTimeStamp)
        
        serviceMainstremTimeStamp.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
        serviceMainstremTimeStamp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        serviceMainstremTimeStamp.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5).isActive = true
        serviceMainstremTimeStamp.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/8).isActive = true
        
    }




}
