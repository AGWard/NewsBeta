//
//  HomeController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///*************************************************************************PROPERTY/VIEWS SETUP*****************************************************************************************************//
    
 
    let cellId = "cellID"
    

    
    let menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.backgroundColor = .darkText
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.layer.masksToBounds = true
        mb.clipsToBounds = true
        
        return mb
    }()
    
    
    
    lazy var titleButtonLabel: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitle("TriniNews", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 30) //CGRectMake(0, 0, 30, 30)
//        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        
        return button
        
    }()

    
    
    
    lazy var rightButtonView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        
        
        
        return view
    }()
    
    
    lazy var rightbarPic: UIImageView = {
        
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        pic.layer.cornerRadius = 0.5 * 40
        pic.layer.borderWidth = 1
        pic.clipsToBounds = true
        pic.image = UIImage(named: "default")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NavtitleTapped)))
        
        
        return pic
    }()
    
    
    
    
//    lazy var rightButtonLabel: UILabel = {
//        
//       let button = UILabel()
//        button.translatesAutoresizingMaskIntoConstraints = false
////        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
//        button.backgroundColor = .clear
//        button.text = "Welcome"
//        button.textColor = .white
//        button.font = UIFont(name: "Avenir Next", size: 13)
//        button.textAlignment = .center
//        
//        
//        
//        return button
//    }()
//    
    
//    lazy var leftButton: UIButton = {
//        
//        let button = UIButton(type: .custom)
//        button.setTitle("<Logout", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.frame = CGRect(x: 0, y: 0, width: 60, height: 30) //CGRectMake(0, 0, 30, 30)
//        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
//       
//       
//        return button
//        
//    }()
    

///******************************************************************************VIEW DID LOAD*******************************************************************************************************//    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
                
        checkIfUserIsLoggedIn()
        
        
        super.viewWillAppear(true)
        
        
        addCollectionView()
//        let barButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButtonView)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.navigationItem.leftBarButtonItem = barButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.titleView = titleButtonLabel
        
        rightBarViewConstraints()
        menuBarConstraints()
        
        
        
    }
    
    ///*****************************************************************************CONSTRAINT FUNCTIONS*************************************************************************************************//
    
    
    private func menuBarConstraints() {
        
        view.addSubview(menuBar)
        
        menuBar.widthAnchor.constraint(equalToConstant: 380).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        
        
        
    }
    
    
    
    
    
    func rightBarViewConstraints() {
        
        rightButtonView.addSubview(rightbarPic)
//        rightButtonView.addSubview(rightButtonLabel)
        
        
        rightbarPic.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightbarPic.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rightbarPic.centerXAnchor.constraint(equalTo: rightButtonView.centerXAnchor).isActive = true
        rightbarPic.centerYAnchor.constraint(equalTo: rightButtonView.centerYAnchor).isActive = true
        
//        rightButtonLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        rightButtonLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        rightButtonLabel.topAnchor.constraint(equalTo: rightButtonView.topAnchor, constant: 0).isActive = true
//        rightButtonLabel.centerXAnchor.constraint(equalTo: rightButtonView.centerXAnchor).isActive = true
        
        
    }
    

  
    
   
    
    func checkIfUserIsLoggedIn() {
        
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            print("not signed in")
            
        }
        else {
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    if let profileImageURLs = dictionary["profileImageURL"] as? String {
                    
//                    self.rightButtonLabel.text = dictionary["name"] as? String
                    self.rightbarPic.loadImagesUsingCacheWithURLString(urlString: profileImageURLs)
                   
                    
                    
                    
                    print(dictionary)
                    }
                    
                }
                
            }, withCancel: nil)
            
        }
    }

    
    
    func handleLogout() {
        
        
        do {
            
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            
            print(logoutError)
            return
        }
        
        let loginVC = LoginController()
        loginVC.modalPresentationStyle = .overCurrentContext
        
        present(loginVC, animated: true, completion: nil)
        
    }
    
    func NavtitleTapped() {
        
        let userHome = UserHomePageController()
        userHome.modalPresentationStyle = .pageSheet
        
        let navC = UINavigationController(rootViewController: userHome)
        

        present(navC, animated: true, completion: nil)
        
    }
    
    
    
  ///*****************************************************************************COLLECTIONVIEW CELLS*************************************************************************************************//
    
    
    
    func addCollectionView() {
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionV = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionV.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.isPagingEnabled = true
        collectionV.contentInset = UIEdgeInsetsMake(140, 0, 0, 0)
        
        view.addSubview(collectionV)
        
    }
    
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        let colors: [UIColor] = [.blue, .green, .yellow, .red]
        
       cell.backgroundColor = colors[indexPath.item]
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
