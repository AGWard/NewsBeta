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
    
let feedCellID = "cellID"
let mainStreamID = "MainStreamID"
    let policeID = "policeCellID"
    let kIPsID = "KIPCellID"

    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  Property/Views Setup *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    lazy var blur: UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let views = UIVisualEffectView(effect: blurEffect)
        views.translatesAutoresizingMaskIntoConstraints = false
        views.isHidden = true
        
        
        return views
        
    }()


    
    
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
        button.text = firstIconHeading
        button.textAlignment = .center
        button.textColor = .darkText
        button.font = UIFont.boldSystemFont(ofSize: 16)
        button.isUserInteractionEnabled = true
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postNewsAction)))
        button.frame = CGRect(x: 0, y: 0, width: 90, height: 30)

        
        
        return button
        
    }()

    
    
    
    lazy var choosePhotoMenuIcon: UIImageView = {
        
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 0.5 * 30
        button.alpha = 0.0
        button.clipsToBounds = true
        button.image = UIImage(named: "photos")
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postNewsAction)))
        
        return button
    }()
    
    
    lazy var accessUserMenuButton: UIImageView = {
        
       let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 0.5 * 30
        button.alpha = 1.0
        button.clipsToBounds = true
        button.image = UIImage(named: "home")
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        return button
    }()
    
    
    lazy var rightbarPic: UIImageView = {
        
        let pic = UIImageView()
        pic.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        pic.contentMode = .scaleAspectFit
        pic.image = UIImage(named: "menublack")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandMenu)))
        
        
        return pic
    }()
    

    
//    lazy var titleLogo: UIImageView = {
//        
//        let pic = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
//        pic.contentMode = .scaleAspectFit
//        pic.clipsToBounds = true
//        pic.image = UIImage(named: "logoNews")
////        pic.isUserInteractionEnabled = true
////        
////        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postNewsAction)))
//        
//        
//        return pic
//    }()

    
    
    
    
    
    
    
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
        
 
        
        UIApplication.shared.statusBarStyle = .default
//        let leftLabel = UIBarButtonItem(customView: leftNavLabel)
        let rightBarButton = UIBarButtonItem(customView: rightbarPic)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.navigationItem.leftBarButtonItem = leftLabel
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationItem.titleView = titleLogo
        self.navigationItem.titleView = titleLabel
        
        menuBarConstraints()
        blurConstraints()
        menuBarBlurConstrainsts()
        
        
        
        
        
        
    }
    

    
        

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  View functions *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
   
    
    
    
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellID, for: indexPath) as! FeedCell
        cell.backgroundColor = .clear
        
        
        if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainStreamID, for: indexPath) as! MainStreamCell
        
            return cell
 
        } else if indexPath.item == 2 {
            
            let policeCell = collectionView.dequeueReusableCell(withReuseIdentifier: policeID, for: indexPath) as! PoliceAlertCell
            
            return policeCell
        } else if indexPath.item == 3 {
            
            
            let kipCell = collectionView.dequeueReusableCell(withReuseIdentifier: kIPsID, for: indexPath) as! KIPCell
            
            return kipCell
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 40)
    }
    
    
    
    
    func expandMenu() {
        

        
        if blur.center.x == 0 {
            
            
        
            blur.frame = CGRect(x: 400, y: 0, width: view.frame.width, height: view.frame.height)
            
        }
        
        

        
        self.blur.isHidden = false
        

    
        
        if rightbarPic.image == #imageLiteral(resourceName: "menublack") {
  
            

            UIView.animate(withDuration: 0.5, animations: { 
                
                self.blur.frame = CGRect(x: 150, y: 0, width: self.view.frame.width, height: self.view.frame.height)

                
                self.view.layoutIfNeeded()
            
            
                UIView.animate(withDuration: 0.8) {

                    
                   
                    self.titleLabel.isHidden = true
                    self.rightbarPic.image = UIImage(named: "menuwhite1")
                    self.collectionVw.isUserInteractionEnabled = false
                    self.menuBar.isUserInteractionEnabled = false
                    self.collectionVw.alpha = 0.7
                    self.menuBar.collecV.alpha = 0.7
                    

            
                
            }
                
                if self.blur.center.x == 337.5 {
                    
                   
  
                }
            

                
                })

        } else {
           
            
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.choosePhotoMenuIcon.alpha = 0.0
                self.choosePhotoMenuIcon.center.x = 100
                
           
            
            
            UIView.animate(withDuration: 0.5) {
                
                self.rightbarPic.image = UIImage(named: "menublack")
                self.accessUserMenuButton.alpha = 0.0
                self.accessUserMenuButton.center.x = self.rightbarPic.center.x
                self.choosePhotoMenuIcon.center.x = self.rightbarPic.center.x
                self.titleLabel.isHidden = false
                self.collectionVw.isUserInteractionEnabled = true
                self.menuBar.isUserInteractionEnabled = true
                self.collectionVw.alpha = 1.0
                self.menuBar.collecV.alpha = 1.0
                
            }
                
                UIView.animate(withDuration: 3.0, animations: {
                    self.blur.center.x = 800
                    
                })
            
                
         })


            
            
        }
        
        

        
   

        
        
    }
    

   
    
    
}
