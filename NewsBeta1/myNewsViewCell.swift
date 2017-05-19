//
//  myNewsViewCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/2/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class myNewsViewCell: BaseCell {
    
    lazy var photoView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
        return postedView
        
        
    }()
    
    
    lazy var newsHeadline: UILabel = {
        
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKING NEWS"
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        
        
        return label
        
    }()
    
    override func setupViews() {
        super.setupViews()
        
      collectionViewConstraints()
        
    }
    
    
    func collectionViewConstraints() {
        
        
        
        addSubview(photoView)
        addSubview(newsHeadline)
        
        photoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        photoView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        photoView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/4).isActive = true
        photoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        newsHeadline.leftAnchor.constraint(equalTo: photoView.rightAnchor, constant: 10).isActive = true
        newsHeadline.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        newsHeadline.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        newsHeadline.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
