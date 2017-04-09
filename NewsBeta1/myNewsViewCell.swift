//
//  myNewsViewCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/2/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class myNewsViewCell: BaseCell {
    
    let photoView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
        return postedView
        
        
    }()
    
    override func setupViews() {
        super.setupViews()
        
      photoViewContraints()
        
    }
    
    
    func photoViewContraints() {
        
        
        
        addSubview(photoView)
        
        photoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        photoView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        photoView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        photoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    
    
    
    
}
