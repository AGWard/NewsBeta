//
//  ShakingTextField.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {
    
    
    
    
    func shake() {
        
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 6, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 6, y: self.center.y))
        
        
        self.layer.add(animation, forKey: "position")
        
    }
    
    
    
    
}
