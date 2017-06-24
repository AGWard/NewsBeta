//
//  MyNewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/28/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class MyNewsCell: BaseCell {

    lazy var photoView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
        return postedView
        
        
    }()
    
    


    
    override func setupViews() {
        super.setupViews()
        
        addConstraints()
        
        
    }
    
    func addConstraints() {
        
        addSubview(photoView)
        
        photoView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        photoView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true

    }
    
    
    
}
