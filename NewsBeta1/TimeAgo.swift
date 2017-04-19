//
//  TimeAgo.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/15/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

extension Date {
    
    
    func timeAgoDisplay() -> String {
        
        let minute = 60
        let hour  = 60 * 60
        let day = hour * 24
        let week = day * 7
        let month = day * 30
        let year = month * 12
        
        
        
        let timeAgo = Int(Date().timeIntervalSince(self))
        
        if timeAgo < minute {
            
            return "\(timeAgo) seconds ago"
            
        } else if timeAgo < hour {
            
            return "\(timeAgo / minute) minutes ago"
            
        } else if timeAgo < day {
            
            return "\(timeAgo / hour) hours ago"
            
        } else if timeAgo < week {
            
            return "\(timeAgo / day) days ago"
            
            
        } else if timeAgo < month {
            
            return "\(timeAgo / week) weeks ago"
            
        } else if timeAgo < year {
            
            return "\(timeAgo / month) months ago"
            
        }
        
        return "\(timeAgo / year) years ago"
        
        
        
        
    }
    
    
    
    
}


