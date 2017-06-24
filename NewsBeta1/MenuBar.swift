//
//  MenuBar.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/16/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

let firstIconHeading = "NewsFeed"
let secondIconHeading = "Mainstream"
let thirdIconHeading = "Services"
let fourthIconHeading = "Subscriptions"
let fifthIconHeading = "K.I.Ps"


class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    var userProfile: UserHomePageController?

    
    let menuIcons = [UIImage(named: "D News"), UIImage(named: "Public News"), UIImage(named: "Police"), UIImage(named: "subscriptions"), UIImage(named: "KIP")]
    
    
    
    let cellIDs = "cellID"
    
    
    lazy var collecV: UICollectionView = {
        
       let layout  = UICollectionViewFlowLayout()
        
        let collec = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collec.translatesAutoresizingMaskIntoConstraints = false
        collec.dataSource = self
        collec.delegate = self
        collec.backgroundColor = .white
        
        
        
        return collec
        
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionViewConstraints()
        collecV.register(MenuCell.self, forCellWithReuseIdentifier: cellIDs)
        
        
        //default a selected cell at loading
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collecV.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
        setupHorizontalScrollBar()
        
        
        
    }
    
    var barLeftAnchor: NSLayoutConstraint?
    
    func setupHorizontalScrollBar() {
        
        let bar = UIView()
        bar.backgroundColor = .darkText
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        
        let redBarLeft = UIView()
        redBarLeft.backgroundColor = .red
        redBarLeft.translatesAutoresizingMaskIntoConstraints = false
        
        
        let whiteBar = UIView()
        whiteBar.backgroundColor = .white
        whiteBar.translatesAutoresizingMaskIntoConstraints = false
        
        let middleBlackBar = UIView()
        middleBlackBar.backgroundColor = .darkText
        middleBlackBar.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(bar)
        
        barLeftAnchor = bar.leftAnchor.constraint(equalTo: self.leftAnchor)
        barLeftAnchor?.isActive = true
        bar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5).isActive = true
        bar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        bar.addSubview(redBarLeft)
        
        redBarLeft.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 1/2).isActive = true
        redBarLeft.heightAnchor.constraint(equalTo: bar.heightAnchor).isActive = true
        redBarLeft.centerXAnchor.constraint(equalTo: bar.centerXAnchor).isActive = true
        redBarLeft.bottomAnchor.constraint(equalTo: bar.bottomAnchor).isActive = true
        
        redBarLeft.addSubview(whiteBar)
        
        whiteBar.widthAnchor.constraint(equalTo: redBarLeft.widthAnchor, multiplier: 1/2).isActive = true
        whiteBar.heightAnchor.constraint(equalTo: redBarLeft.heightAnchor).isActive = true
        whiteBar.centerXAnchor.constraint(equalTo: redBarLeft.centerXAnchor).isActive = true
        whiteBar.bottomAnchor.constraint(equalTo: redBarLeft.bottomAnchor).isActive = true
        
        whiteBar.addSubview(middleBlackBar)
        
        middleBlackBar.widthAnchor.constraint(equalTo: whiteBar.widthAnchor, multiplier: 3/4).isActive = true
        middleBlackBar.heightAnchor.constraint(equalTo: whiteBar.heightAnchor).isActive = true
        middleBlackBar.centerXAnchor.constraint(equalTo: whiteBar.centerXAnchor).isActive = true
        middleBlackBar.bottomAnchor.constraint(equalTo: whiteBar.bottomAnchor).isActive = true
        
        
        
        
    }
    
    
    
    func collectionViewConstraints() {
        addSubview(collecV)
        
        collecV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collecV.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collecV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let intIndex = Int(indexPath.item)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
        switch intIndex {
        case 0:
            homeController?.titleLabel.text = firstIconHeading
        case 1:
            homeController?.titleLabel.text = secondIconHeading
        case 2:
            homeController?.titleLabel.text = thirdIconHeading
        case 3:
            homeController?.titleLabel.text = fourthIconHeading
        case 4:
            homeController?.titleLabel.text = fifthIconHeading
        default:
            print("other")
        }

        

    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menuIcons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs, for: indexPath) as! MenuCell

        cell.menuIconB.image = menuIcons[indexPath.item]
       
       
        
        cell.awakeFromNib()

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5.05, height: frame.height)
    }
    
    //gets rid of default spacing between cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
