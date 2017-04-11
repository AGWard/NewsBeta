//
//  BaseCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/9/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    func setupViews() {
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


