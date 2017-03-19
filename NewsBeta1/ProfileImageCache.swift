//
//  ProfileImageCache.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/5/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView {
    
    
    func loadImagesUsingCacheWithURLString(urlString: String) {
        
        //check cache for image first
        
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
            
            self.image = cachedImage as? UIImage
            return
            
        }
        
        
        let uurls = URL(string: urlString)
        URLSession.shared.dataTask(with: uurls!, completionHandler: { (data, response, error) in
            
            if error != nil {
                
                print(error!)
                return
            }
            
            print("picture retrieved")
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    DispatchQueue.main.async {
                        
                        self.image = downloadedImage
                    }

                    
                    
                }
                
                
        }
            
            
            
        }).resume()

        
        
        
        
        
    }
    
    
    
    
    func loadImagesUsingCachewithPhotoLIb(photoImages: UIImage) {
        
        if let cachedImages = imageCache.object(forKey: photoImages as AnyObject) {
            
            self.image = cachedImages as? UIImage
            return
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
}
