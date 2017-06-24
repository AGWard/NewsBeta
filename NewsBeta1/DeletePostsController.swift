//
//  DeletePostsController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/28/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class DeletePostsController: UIViewController {
    
    var postedPic: UIImage?
    var imageName: String?
    var videoName: String?
    var timeStamp: String?
    
    lazy var networkRequest: NetworkingService = {
        
        let netReq = NetworkingService()
        netReq.deletePost = self
        
        
        
        return netReq
    }()

    
    lazy var newsHeadline: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.backgroundColor = .white
        
        
        return label
        
    }()

    
    lazy var postedImageView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
        
        return postedView

        
    }()
    
    
    lazy var deleteButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Delete Post", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deletePosts), for: .touchUpInside)
        
        return button
    }()

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        addConstraints()
        postedImageView.image = postedPic
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func handleDismiss() {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func addConstraints() {
        
        view.addSubview(newsHeadline)
        view.addSubview(postedImageView)
        view.addSubview(deleteButton)
        
        newsHeadline.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5).isActive = true
        newsHeadline.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        newsHeadline.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        postedImageView.topAnchor.constraint(equalTo: newsHeadline.bottomAnchor, constant: 5).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        postedImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        postedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
    }
    
    
  
        
    
    @objc func deletePosts() {
        
        
        let alert = UIAlertController(title: "Delete Post?", message: "You are about to delete this post, are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { (alert: UIAlertAction) in
            
            let path = self.timeStamp
            
            self.networkRequest.deletePosts(feedpath: path!, imageName: self.imageName, videoName: self.videoName)
            
            }
        )
        
        
        present(alert, animated: true, completion: nil)
        
      
        
    }
    
    
    func presentUserHomePage() {
        
        let userHome = UserHomePageController()
        userHome.modalPresentationStyle = .fullScreen
        
        let navC = UINavigationController(rootViewController: userHome)
        
        present(navC, animated: true, completion: nil)
        
        
    }
    
    


}
