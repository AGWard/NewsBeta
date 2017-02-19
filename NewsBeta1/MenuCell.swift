//
//  MenuCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/16/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let selectedColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    
    let menuLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.tintColor = .red
        label.backgroundColor = .darkText
        label.font = UIFont(name: "Avenir Next", size: 16)
        
        return label
    }()
    
    
    let menuIconB: UIImageView = {
        
       let icons = UIImageView()
        icons.translatesAutoresizingMaskIntoConstraints = true
        icons.contentMode = .scaleAspectFit
        icons.clipsToBounds = true
        

        
        return icons
        
    }()
    
    
    
    override var isHighlighted: Bool {
        
        didSet {
            
            menuIconB.backgroundColor = isHighlighted ? selectedColor : .white
        }
        
    
        
    }

    override var isSelected: Bool {
        
        didSet {
            
            menuIconB.backgroundColor = isSelected ? selectedColor : .white
        }
        
    }
    
    
    
    override func awakeFromNib() {
        
        contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        contentView.addSubview(menuLabel)
        contentView.addSubview(menuIconB)
        setupConstraints()
        
    }
    
    
    
    func setupConstraints() {
        
//        menuLabel.frame = contentView.frame
        menuIconB.frame = contentView.frame
        
    }
    
    
}
