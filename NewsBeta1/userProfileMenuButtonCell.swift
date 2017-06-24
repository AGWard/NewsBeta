//
//  userProfileMenuButtonCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/25/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class userProfileMenuButtonCell: BaseCell {
    
    
    override var isHighlighted: Bool {
        
        didSet {
            
            menuIconB.backgroundColor = isHighlighted ? .black : .white
            menulabel.textColor = isHighlighted ? .white : .black
        }
        
    }
    
    override var isSelected: Bool {
        
        didSet {
            
            menuIconB.backgroundColor = isSelected ? .black : .white
            menulabel.textColor = isSelected ? .white : .black
        }
        
    }
    
    lazy var menulabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 10)
     
        
        return label
    }()
    
    
    
    
    lazy var menuIconB: UIImageView = {
        
        let icons = UIImageView()
        icons.translatesAutoresizingMaskIntoConstraints = false
        icons.contentMode = .scaleAspectFit
        icons.clipsToBounds = true
        icons.backgroundColor = .white
        
        return icons
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        menuIconBConstraints()
        menuLabelConstraints()
        
    }

    func menuIconBConstraints() {
        
        addSubview(menuIconB)
        
        menuIconB.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        menuIconB.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        
    }
    
    func menuLabelConstraints() {
        
        
        addSubview(menulabel)
        
        menulabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        menulabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    
}
