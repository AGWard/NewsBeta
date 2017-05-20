//
//  HomeController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase




class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CellSegaway2Delegate {
    
 
    
    
    let feedCellID = "cellID"
    let mainStreamID = "MainStreamID"
    let policeID = "policeCellID"
    let kIPsID = "KIPCellID"

    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  Property/Views Setup *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    var database = [DatabaseProperties]()
    

    
    
    lazy var collectionVw: UICollectionView = {
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.isPagingEnabled = true
        collectionV.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
        
        
        return collectionV
    }()
    
 
    
    lazy var menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.backgroundColor = .darkText
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.layer.masksToBounds = true
        mb.clipsToBounds = true
        mb.homeController = self
        
        return mb
    }()
    
    
    
    lazy var titleLabel: UILabel = {
        
        let button = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        button.text = firstIconHeading
        button.textAlignment = .center
        button.textColor = .red
        button.font = UIFont.boldSystemFont(ofSize: 16)

        
        
        return button
        
    }()

    

    
    
    lazy var rightbarPic: UIImageView = {
        
        let pic = UIImageView()
        pic.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        pic.contentMode = .scaleAspectFit
        pic.image = UIImage(named: "settings")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
        return pic
    }()
    
    
    lazy var leftBarPic: UIImageView = {
        
        let pic = UIImageView()
        pic.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        pic.contentMode = .scaleAspectFit
        pic.image = UIImage(named: "video2")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postNewsAction)))
        
        
        return pic
        
        
    }()
    

    

    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                // ***************  View Did Load/Will Appear *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        checkIfUserIsLoggedIn()
        view.backgroundColor = .darkText
        
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("*************memory warning HomeCtroller")
       
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                
        
        
        collectionViewConstraints()
        
 
        
        UIApplication.shared.statusBarStyle = .default
        let leftLabel = UIBarButtonItem(customView: leftBarPic)
        let rightBarButton = UIBarButtonItem(customView: rightbarPic)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.navigationItem.leftBarButtonItem = leftLabel
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationItem.titleView = titleLogo
        self.navigationItem.titleView = titleLabel
        
        menuBarConstraints()

        
        
    }
    

    
        

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  View functions *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
   
    
    
    
    func checkIfUserIsLoggedIn() {
        
        
        if Auth.auth().currentUser?.uid == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            print("not signed in")
            
        }
            
        else {
 
            let uid = Auth.auth().currentUser?.uid
            
            let networkRequest = NetworkingService()
            
            networkRequest.getUserInfo(parentRef: firebaseParentUser, childRef: uid!, screen: "home")
        
            
        }
    }

    
    
    func handleLogout() {
        
        
        do {
            
            try Auth.auth().signOut()
        } catch let logoutError {
            
            print(logoutError)
            return
        }
        
        let loginVC = LoginController()
        loginVC.modalPresentationStyle = .overCurrentContext
        
        present(loginVC, animated: true, completion: nil)
        
    }
    

    
    func otherUserTapped(userID: String, userName: String) {
        
       
        
        let otherUserC = OtherUserController()
        otherUserC.modalPresentationStyle = .pageSheet
        otherUserC.userID = userID
        otherUserC.userName = userName
        let navC = UINavigationController(rootViewController: otherUserC)
        
        present(navC, animated: true, completion: nil)
        
    }
    
    
    func profilePicTapped() {
        
       
        
        let userHome = UserHomePageController()
        userHome.modalPresentationStyle = .pageSheet
        
        let navC = UINavigationController(rootViewController: userHome)
        

        present(navC, animated: true, completion: nil)
        

        
    }
    
    func postNewsAction() {
        
        let mediaController = UserPhotoController()
        mediaController.modalPresentationStyle = .popover
        
        let navController = UINavigationController(rootViewController: mediaController)
        
        present(navController, animated: true, completion: nil)
        
        
    }
    

    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  CollectionView Setup *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    

    
    //******Scroll bar functionality on menu bar*********//
    
    
    
    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionVw.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
  
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.barLeftAnchor?.constant = scrollView.contentOffset.x / 4
        
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let intIndex = Int(index)
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collecV.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        
        switch intIndex {
        case 0:
            titleLabel.text = firstIconHeading
        case 1:
            titleLabel.text = secondIconHeading
        case 2:
            titleLabel.text = thirdIconHeading
        case 3:
            titleLabel.text = fourthIconHeading
        default:
            print("Run out of Menu Names!!!!")
        }
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
          
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellID, for: indexPath) as! FeedCell
            cell.backgroundColor = .clear
            cell.delegate = self
            
            return cell
            
        } else if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainStreamID, for: indexPath) as! MainStreamCell
        
            return cell
 
        } else if indexPath.item == 2 {
            
            let policeCell = collectionView.dequeueReusableCell(withReuseIdentifier: policeID, for: indexPath) as! ServicesCell
            
            return policeCell
            
        } else if indexPath.item == 3 {
            
            
            let kipCell = collectionView.dequeueReusableCell(withReuseIdentifier: kIPsID, for: indexPath) as! KIPCell
            
            return kipCell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height - 40)
        
        
        
        
        
        
    }
    

    
    
    
}
