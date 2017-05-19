//
//  MoreOptionsViewCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/17/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class MoreOptionsViewCell: BaseCell {
    
    override var isHighlighted: Bool {
        
        didSet {
            
            
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            labelImages.tintColor = isHighlighted ? .white : .red
            
        }
        
        
        
    }
    
    
    var menuList: MenuList? {
        
        didSet {
            
            nameLabel.text = menuList?.names
            labelImages.image = UIImage(named: (menuList?.imageName)!)?.withRenderingMode(.alwaysTemplate)
            labelImages.tintColor = .red
            
        }
        
    }
    
    
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var labelImages: UIImageView = {
        
       let images = UIImageView()
        images.translatesAutoresizingMaskIntoConstraints = false
        images.contentMode = .scaleAspectFit
        images.clipsToBounds = true
        
       
        
        
        return images
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
        
        addConstraints()
        
        
        
    }
    
    
    func addConstraints() {
        
        addSubview(labelImages)
        addSubview(nameLabel)
        
        labelImages.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        labelImages.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelImages.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/6).isActive = true
        labelImages.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        
        
        nameLabel.leftAnchor.constraint(equalTo: labelImages.rightAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        
        
        
        
    }

    
}
