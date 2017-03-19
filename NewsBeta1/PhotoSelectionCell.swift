//
//  PhotoSelectionCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/5/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class PhotoSelectionCell: BaseCell {
    
    
   lazy var photoView: UIImageView = {
        
       let lable = UIImageView()
        lable.backgroundColor = .red
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.contentMode = .scaleAspectFill
        lable.clipsToBounds = true
        
        
        
        return lable
    }()
    
    

    
    override func setupViews() {
        super.setupViews()
        
        
        backgroundColor = .yellow
        lableCOnstraints()
    }

    
    
    func lableCOnstraints() {
        
        addSubview(photoView)
        
        photoView.frame = contentView.frame
        
    }

    
    
}
