//
//  NewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/13/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class TriniNewsCell: BaseCell {
    
    
    let postedImageView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        
       return postedView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        postedImageViewConstraints()
        
        
    }
    
    func postedImageViewConstraints() {
        
        addSubview(postedImageView)
        
        postedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        postedImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        postedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    
    
}
