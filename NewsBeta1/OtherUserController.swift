//
//  OtherUserController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/15/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class OtherUserController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var imageURLS: [String] = []
    var newsHeadline: [String] = []
    var postedText: [String] = []
    let cellIDs = "cellID"
    var userID: String?
    var userName: String?
    
    
    lazy var otherUserCollectionView: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       
        
        let collecV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecV.translatesAutoresizingMaskIntoConstraints = false
        collecV.backgroundColor = .lightGray
        collecV.dataSource = self
        collecV.delegate = self
        
        return collecV
        
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissController))
        navigationItem.title = userName
       otherUserCollectionViewConstraints()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func dismissController() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func otherUserCollectionViewConstraints() {
        
        view.addSubview(otherUserCollectionView)
        otherUserCollectionView.register(OtherUsertCell.self, forCellWithReuseIdentifier: cellIDs)
        
        
        
        otherUserCollectionView.frame = view.bounds
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var cellCounter = 0
        
        
        for number in 0..<reveredArrays.count {
            
            
            if userID == reveredArrays[number].userID {
                
                imageURLS.append(reveredArrays[number].postedPicURL!)
                newsHeadline.append(reveredArrays[number].newsHeadlines!)
                postedText.append(reveredArrays[number].postedText!)
                
                cellCounter += 1
                
            }
            
        }
        
        
        return cellCounter
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs, for: indexPath) as! OtherUsertCell
        
        cell.postedImageView.sd_setImage(with: URL(string: imageURLS[indexPath.item]))
        cell.newsHeadingLabel.text = newsHeadline[indexPath.item]
        cell.postedTextView.text = postedText[indexPath.item]
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width, height: view.bounds.height / 4)
    }



}
