//
//  HomeController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase




class BaseCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    func setupViews() {
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}





class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///*************************************************************************PROPERTY/VIEWS SETUP*****************************************************************************************************//

    
    
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
    
 
    let cellId = "cellID"
   

    
    lazy var menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.backgroundColor = .darkText
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.layer.masksToBounds = true
        mb.clipsToBounds = true
        mb.homeController = self
        
        return mb
    }()
    
    
    
    lazy var leftNavLabel: UILabel = {
        
        let button = UILabel()
        button.text = "TriniNews"
        button.textColor = .red
        button.font = UIFont.boldSystemFont(ofSize: 16)
        button.frame = CGRect(x: 0, y: 0, width: 90, height: 30) //CGRectMake(0, 0, 30, 30)
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
//        pic.layer.borderWidth = 2
//        pic.layer.borderColor = UIColor.red.cgColor
        pic.clipsToBounds = true
        pic.image = UIImage(named: "default")
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
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
    
    lazy var titleLogo: UIImageView = {
        
        let pic = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        pic.contentMode = .scaleAspectFit
        pic.layer.cornerRadius = 0.5 * 40
        //        pic.layer.borderWidth = 2
        //        pic.layer.borderColor = UIColor.red.cgColor
        pic.clipsToBounds = true
        pic.image = UIImage(named: "logoNews")
        pic.isUserInteractionEnabled = false
//        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePicTapped)))
        
        
        return pic
    }()

    

///******************************************************************************VIEW DID LOAD*******************************************************************************************************//    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkText
        
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
                
        checkIfUserIsLoggedIn()
        
        
        super.viewWillAppear(true)
        
        
        collectionViewConstraints()
        let leftLabel = UIBarButtonItem(customView: leftNavLabel)
        let rightBarButton = UIBarButtonItem(customView: rightButtonView)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.navigationItem.leftBarButtonItem = leftLabel
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.titleView = titleLogo
        
        rightBarViewConstraints()
        menuBarConstraints()
        
        
        
        
        
    }
    
    ///*****************************************************************************CONSTRAINT FUNCTIONS*************************************************************************************************//
    
    
    
    func collectionViewConstraints() {
        
        collectionVw.register(FeedCell.self, forCellWithReuseIdentifier: cellId)

        
        view.addSubview(collectionVw)

        collectionVw.frame = view.frame
        
    }
    
    
    
    
    private func menuBarConstraints() {
        
        view.addSubview(menuBar)
        
        navigationController?.hidesBarsOnSwipe = true
        
        
//        menuBar.widthAnchor.constraint(equalToConstant: 380).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        
        
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
    
    func profilePicTapped() {
        
        let userHome = UserHomePageController()
        userHome.modalPresentationStyle = .pageSheet
        
        let navC = UINavigationController(rootViewController: userHome)
        

        present(navC, animated: true, completion: nil)
        
    }
    
    
    
  ///*****************************************************************************COLLECTIONVIEW CELLS*************************************************************************************************//
    
    
    
//    func addCollectionView() {
//        
//        
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionHeadersPinToVisibleBounds = true
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
//        
//        let collectionV = UICollectionView(frame: view.frame, collectionViewLayout: layout)
//        collectionV.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
//        collectionV.backgroundColor = .white
//        collectionV.delegate = self
//        collectionV.dataSource = self
//        collectionV.isPagingEnabled = true
//        collectionV.contentInset = UIEdgeInsetsMake(140, 0, 0, 0)
//        
//        view.addSubview(collectionV)
//        
//    }
    
    
    
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
            leftNavLabel.text = "Trini News"
        case 1:
            leftNavLabel.text = "Top Stories"
        case 2:
            leftNavLabel.text = "Favourites"
        case 3:
            leftNavLabel.text = "Trending"
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
    

    
    
    
}
