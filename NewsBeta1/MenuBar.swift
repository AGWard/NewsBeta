//
//  MenuBar.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/16/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit


class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?

    
    let menuIcons = [UIImage(named: "T&T Flag"), UIImage(named: "globe35"), UIImage(named: "favs"), UIImage(named: "trending")]
    
    
    
    let cellIDs = "cellID"
    
    
    lazy var collecV: UICollectionView = {
        
       let layout  = UICollectionViewFlowLayout()
        let collec = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collec.translatesAutoresizingMaskIntoConstraints = false
        collec.dataSource = self
        collec.delegate = self
        
        
        
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
        
        
        
        addSubview(bar)
        
        barLeftAnchor = bar.leftAnchor.constraint(equalTo: self.leftAnchor)
        barLeftAnchor?.isActive = true
        bar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        bar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
    }
    
    
    
    func collectionViewConstraints() {
        addSubview(collecV)
        
        collecV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collecV.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collecV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
//        
//        
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        barLeftAnchor?.constant = x
//        
//        UIView.animate(withDuration: 0.70, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        let intIndex = Int(indexPath.item)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
        switch intIndex {
        case 0:
            homeController?.leftNavLabel.text = "Trini News"
        case 1:
            homeController?.leftNavLabel.text = "Top Stories"
        case 2:
            homeController?.leftNavLabel.text = "Favourites"
        case 3:
            homeController?.leftNavLabel.text = "Trending"
        default:
            print("oither")
        }

        

    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs, for: indexPath) as! MenuCell
        
//        cell.menuLabel.text = menuLabels[indexPath.item]
        cell.menuIconB.image = menuIcons[indexPath.item]
       
       
        
        cell.awakeFromNib()

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    //gets rid of default spacing between cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
