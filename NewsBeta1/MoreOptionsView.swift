//
//  MoreOptionsView.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/17/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit


class MenuList: NSObject {
    
    
    let names: String
    let imageName: String
    
    
    init(name: String, imageName: String) {
        
        self.names = name
        self.imageName = imageName
        
    }
    
    
    
}




class MoreOptionsView: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var triniNewsCell: TriniNewsCell?
    
    let menuList: [MenuList] = {
        
        return [MenuList(name: "Settings", imageName: "settingsOpt"), MenuList(name: "Report Abuse", imageName: "report"), MenuList(name: "Help", imageName: "help1"), MenuList(name: "Cancel", imageName: "cancel")]
    }()
    
    
    let cellIDview = "cellID"
    
    let blackView = UIView()
    
    let moreOptionsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collV.backgroundColor = .white
        
        
        
        return collV
        
    }()
    
    
    func showOptions() {
        
        
        if let window = UIApplication.shared.keyWindow {
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(moreOptionsCollectionView)
            
            let height: CGFloat = 200
            let y = window.frame.height - 200
            
            moreOptionsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.isUserInteractionEnabled = true
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.moreOptionsCollectionView.frame = CGRect(x: 0, y: y, width: self.moreOptionsCollectionView.frame.width, height: self.moreOptionsCollectionView.frame.height)
                self.triniNewsCell?.moreOptionsButton.tintColor = .red
            }, completion: nil)
            
            
        }
        
        
    }
    
    func handleDismiss(options: MenuList) {
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                self.moreOptionsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.moreOptionsCollectionView.frame.width, height: self.moreOptionsCollectionView.frame.height)
                
            }
            

        }) { (completed: Bool) in
            
            self.triniNewsCell?.moreOptionsButton.tintColor = .black
            
            if options.names == "Settings" {
                
                self.triniNewsCell?.goToUserMenu()
            }
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDview, for: indexPath) as! MoreOptionsViewCell
        let list = menuList[indexPath.item]
        
        cell.menuList = list
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: moreOptionsCollectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     let name = menuList[indexPath.item]
            
            handleDismiss(options: name)
        
    }

    
    
    
    override init() {
        super.init()
        
        moreOptionsCollectionView.dataSource = self
        moreOptionsCollectionView.delegate = self
        moreOptionsCollectionView.register(MoreOptionsViewCell.self, forCellWithReuseIdentifier: cellIDview)
        
        
    }
    
    
}


