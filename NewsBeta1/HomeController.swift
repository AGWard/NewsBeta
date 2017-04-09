//
//  HomeController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase




class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
let cellId = "cellID"
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  Property/Views Setup *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    

    
    
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
        
        let button = UILabel()
        button.text = "TriniNews"
        button.textAlignment = .center
        button.textColor = .red
        button.font = UIFont.boldSystemFont(ofSize: 16)
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postNewsAction)))
        button.frame = CGRect(x: 0, y: 0, width: 90, height: 30)

        
        
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
        pic.clipsToBounds = true
        pic.image = UIImage(named: "default")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
        return pic
    }()
    

    
    lazy var titleLogo: UIImageView = {
        
        let pic = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        pic.contentMode = .scaleAspectFit
        pic.layer.cornerRadius = 0.5 * 40
        pic.clipsToBounds = true
        pic.image = UIImage(named: "logoNews")
        pic.isUserInteractionEnabled = true
        
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postNewsAction)))
        
        
        return pic
    }()

    
    
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                // ***************  View Did Load/Will Appear *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkText
        checkIfUserIsLoggedIn()
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                
        
        
        
        collectionViewConstraints()
//        let leftLabel = UIBarButtonItem(customView: leftNavLabel)
        let rightBarButton = UIBarButtonItem(customView: rightButtonView)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.navigationItem.leftBarButtonItem = leftLabel
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationItem.titleView = titleLogo
        self.navigationItem.titleView = titleLabel
        
        rightBarViewConstraints()
        menuBarConstraints()
        
        
        
        
    }
    
        

  
    
   
    
    func checkIfUserIsLoggedIn() {
        
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            print("not signed in")
            
        }
        else {
 
                let uid = FIRAuth.auth()?.currentUser?.uid
                
                let fbAquisition = FireBaseAquistion(userIDNumber: uid!, childRef: parentUser, reference: username, profileImageRef: profileImageURL)
                
                fbAquisition.getUserDetails()
   
            
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
    
    func profilePicTapped() {
        
        let userHome = UserHomePageController()
        userHome.modalPresentationStyle = .pageSheet
        
        let navC = UINavigationController(rootViewController: userHome)
        

        present(navC, animated: true, completion: nil)
        

        
    }
    
    
    
  ///*****************************************************************************COLLECTIONVIEW CELLS*************************************************************************************************//
    
    
    

    
    
    
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
            titleLabel.text = "Trini News"
        case 1:
            titleLabel.text = "Top Stories"
        case 2:
            titleLabel.text = "Favourites"
        case 3:
            titleLabel.text = "Trending"
        default:
            print("oither")
        }
        
    }
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
//        let colors: [UIColor] = [.blue, .green, .yellow, .red]
//        
//       cell.backgroundColor = colors[indexPath.item]
        cell.backgroundColor = .green
               
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 40)
    }
    

    func postNewsAction() {
        
        let mediaController = UserPhotoController()
        mediaController.modalPresentationStyle = .popover
        
        let navController = UINavigationController(rootViewController: mediaController)
    
        present(navController, animated: true, completion: nil)
        
    }
    

    
    
}
