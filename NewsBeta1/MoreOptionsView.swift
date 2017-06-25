//
//  MoreOptionsView.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/17/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class MenuList: NSObject {
    
    
    let names: String
    let imageName: String
    
    
    init(name: String, imageName: String) {
        
        self.names = name
        self.imageName = imageName
        
    }
    
    
    
}




class MoreOptionsView: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var menuList: [MenuList]
    
    
    var triniNewsCell: TriniNewsCell?
    var homeController: HomeController?
    var subscripPage: SubscriptionsFeedCell?
    let networkRequest = NetworkingService()
    
    
    var imageToShare: UIImage?
    var headlineToShare: String?
    var userNameID: String?
    var homeScreen: Bool?
    var selectedPath: IndexPath?
    
    
    let cellIDview = "cellID"
    
    let blackView = UIView()
    
    let moreOptionsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collV.backgroundColor = .white
        
        
        
        return collV
        
    }()
    
    
    
    func showOptions(_ image: UIImage?, headline: String?, userName: String?, screen: Bool?) {
        
        imageToShare = image
        headlineToShare = headline
        userNameID = userName
        homeScreen = screen
        
        if let window = UIApplication.shared.keyWindow {
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(moreOptionsCollectionView)
            
            let height: CGFloat = 200
            let y = window.frame.height - CGFloat(menuList.count * 50)
            
            moreOptionsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.isUserInteractionEnabled = true
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.moreOptionsCollectionView.frame = CGRect(x: 0, y: y, width: self.moreOptionsCollectionView.frame.width, height: self.moreOptionsCollectionView.frame.height + 50)
                self.triniNewsCell?.moreOptionsButton.tintColor = .red
            }, completion: nil)
            
            
        }
        
        
    }
    
    @objc func handleDismiss(_ options: MenuList) {
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                self.moreOptionsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.moreOptionsCollectionView.frame.width, height: self.moreOptionsCollectionView.frame.height + 50)
                
            }
            

        }) { (completed: Bool) in
            
            self.triniNewsCell?.moreOptionsButton.tintColor = .black
            
            
            
            switch options.names {
                
                case "Share":
                    let activityVC = UIActivityViewController(activityItems: [self.headlineToShare!, self.imageToShare!], applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = self.homeController?.view
                    if self.homeScreen == true {
                        self.triniNewsCell?.shareOptionsTapped(activityVC, alert: nil)
                        break
                    } else if self.homeScreen == false {
                        self.subscripPage?.shareOptionsTapped(activityVC, alert: nil)
                        break
                    }
                    break
                case "Subscribe":
                    self.networkRequest.subscribe(self.userNameID!)
                    break
                case "Un-Subscribe":
                    self.networkRequest.unsubscribe(self.userNameID!)
                    break
                case "Report Abuse":
                    self.triniNewsCell?.showAbuseOptions()
                    break
                case "Report!":
                    self.subscripPage?.showAbuseOptions()
                    break
                case "Inappropriate Photo", "Photo Rights", "Hate Speech":
                    if self.selectedPath?.row != 3 && self.selectedPath != nil {
                    self.triniNewsCell?.postAbuseReport(abuseID: self.menuList[(self.selectedPath?.row)!].names)
                        let alert = UIAlertController(title: "Thank You", message: "Your report has been rec'd and an Administrator will review. If you require an urgent response please contact us @ ttnewsfeed@gmail.com", preferredStyle: .alert)
                        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OK)
                        self.triniNewsCell?.shareOptionsTapped(nil, alert: alert)
                        self.selectedPath = nil
                    }
                case "Not Appropriate", "Photo Rights!", "Hate Speech!":
                    if self.selectedPath?.row != 3 && self.selectedPath != nil {
                    self.subscripPage?.postAbuseReport(self.menuList[(self.selectedPath?.row)!].names)
                        let alert = UIAlertController(title: "Thank You", message: "Your report has been rec'd and an Administrator will review. If you require an urgent response please contact us @ ttnewsfeed@gmail.com", preferredStyle: .alert)
                        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OK)
                        self.subscripPage?.shareOptionsTapped(nil, alert: alert)
                        self.selectedPath = nil
                    }

                default:
                    return
                
            }
            

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
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
        selectedPath = indexPath

        
     let name = menuList[indexPath.item]
            
            handleDismiss(name)
        
    }

    
    
    
    init(menuList: [MenuList]) {
        self.menuList = menuList
        super.init()
        
        moreOptionsCollectionView.dataSource = self
        moreOptionsCollectionView.delegate = self
        moreOptionsCollectionView.register(MoreOptionsViewCell.self, forCellWithReuseIdentifier: cellIDview)
        
        
    }
    
    
}


