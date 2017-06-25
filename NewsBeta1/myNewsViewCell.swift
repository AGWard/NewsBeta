//
//  myNewsViewCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/2/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class myNewsViewCell: BaseCell {
    
    var userHome: UserHomePageController?
    
    lazy var networkRequest: NetworkingService = {
        
        let netReq = NetworkingService()
        
        

        
        return netReq
    }()

    
    
    lazy var imgNames: UILabel = {
        
        let label = UILabel()
        
        
        return label
    }()

    
    
    
    lazy var vidNames: UILabel = {
        
        let label = UILabel()
        
        
        return label
    }()

    
    

    lazy var label: UILabel = {
        
       let label = UILabel()
        
        
        return label
    }()

    lazy var deleteButton: UIButton = {
        
       let button = UIButton()
        
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deletePosts), for: .touchUpInside)
        
        return button
    }()
    
    lazy var photoView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
        return postedView
        
        
    }()
    
    
    lazy var newsHeadline: UILabel = {
        
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKING NEWS"
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        
        
        return label
        
    }()
    
    override func setupViews() {
        super.setupViews()
        
      collectionViewConstraints()
        
    }
    
    
    func collectionViewConstraints() {
        
        
        
        addSubview(photoView)
        addSubview(newsHeadline)
        addSubview(deleteButton)
        
        photoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        photoView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        photoView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/4).isActive = true
        photoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        newsHeadline.leftAnchor.constraint(equalTo: photoView.rightAnchor, constant: 10).isActive = true
        newsHeadline.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        newsHeadline.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        newsHeadline.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        
        
        deleteButton.bottomAnchor.constraint(equalTo: newsHeadline.topAnchor, constant: -2).isActive = true
        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: photoView.rightAnchor, constant: 10).isActive = true
        
        
        
    }
    
    
    @objc func deletePosts() {
        
        
        let alert = UIAlertController(title: "Delete Post?", message: "You are about to delete this post, are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { (alert: UIAlertAction) in
            
            let path = self.label.text
            
            self.networkRequest.deletePosts(path!, imageName: self.imgNames.text, videoName: self.vidNames.text)
            
            }
        )
    
      userHome?.present(alert, animated: true, completion: nil)

    }
    
    func refreshData() {
        print("Refresh")
        
        
    }
    
    func refresh2() {
        
        print("lets see")
        
        
        self.userHome?.myNewsCollectionView.reloadData()
    }
    
    
}
