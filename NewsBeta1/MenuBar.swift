//
//  MenuBar.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/16/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit


class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let menuIcons = [UIImage(named: "T&T Flag"), UIImage(named: "globe35"), UIImage(named: "favs"), UIImage(named: "trending")]
    
    let menuLabels: [String] = ["Top Stories", "Trini News", "My Favs", "Popular"]
    
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
        collecV.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .bottom)
        
    }
    
    
    
    func collectionViewConstraints() {
        addSubview(collecV)
        
        collecV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collecV.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collecV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
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
