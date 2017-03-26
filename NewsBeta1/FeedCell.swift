//
//  FeedCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/19/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var postedPhotos: [UIImage] = []
    var imageURLS: [String] = []
    var idlist = [String]()
    
    

    
    let cellID = "cellID"
    
    
    lazy var collectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .darkText
        collection.dataSource = self
        collection.delegate = self
        
        
        return collection
        
    }()
    
    override func setupViews() {
        super.setupViews()
        
        getPostedData()

        backgroundColor = .brown
        collectionViewContraints()
        
       
    }
    
    
    func collectionViewContraints() {
        
        addSubview(collectionViews)
        collectionViews.register(TriniNewsCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionViews.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        collectionViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        collectionViews.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionViews.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageURLS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TriniNewsCell
        cell.backgroundColor = .red
        cell.postedImageView.sd_setImage(with: URL(string: imageURLS[indexPath.item]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let height = (frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: frame.width, height: height + 16 + 88)
        
        return CGSize(width: frame.width, height: 210)
        
    }
    
    
    func getPostedData() {
        
        
        
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        
        
        FIRDatabase.database().reference().child("Users").child(uid!).child("Posted Data").observeSingleEvent(of: .value, with: {(snapshot) in
        
            if let dictionary = snapshot.value as? [String: [String : String]] {
                
                for info in dictionary {
                    
                    self.idlist.append(info.key)
                    
                }
                print("WHAT IS THIS\(self.idlist)")
                
                
                for count in 0..<self.idlist.count {
                
                if let postedData = dictionary[self.idlist[count]]?["postedPicURL"] {
                    
                    
                    self.imageURLS.append(postedData)
                    print("*******POSTED DATA HERE \(postedData)")
                    
                    print("imageURL count is \(self.imageURLS.count) and data is \(self.imageURLS)")
                    
                  self.collectionViews.reloadData()
                    
                    
                }
                }
            }
            
           
        
        
        
        
        
        }, withCancel: nil)
        

        
        
      /*  let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child(uid!).child("Posted Data").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                
                
                if let postedPicURL = dictionary["postedPicURL"] as? String {
                    
                    self.imageURLS.append(postedPicURL)
                    
                    print(self.imageURLS.count)
                    
                    
                    
                    
                    
                }
                
            }
            
        }, withCancel: nil)
 
 */
 
    }
 
 
}



