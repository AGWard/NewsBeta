//
//  MainStreamCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/14/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

protocol PresentWebViewDelegate: class {
    func presentWebView(_ url: String?, author: String?)
}


import UIKit

class MainStreamCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    let mainstreamID = "cellID"
    let mainstreamHeaderID = "headerID"
    
    weak var delegate: PresentWebViewDelegate?
    
    lazy var netReq: NetworkingService = {
        
       let request = NetworkingService()
        request.mainstream = self
        
        return request
        
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        
        let control = UIRefreshControl()
        control.tintColor = .black
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return control
    }()

    
    
    lazy var mainStramCollectionV: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        return collectionView
        
    }()


    
    override func setupViews() {
        super.setupViews()
        fetchArticles()
        mainStreamCollectionViewConstraints()
        mainStramCollectionV.addSubview(refreshControl)
        

        
    }

    
    func mainStreamCollectionViewConstraints() {
        
        addSubview(mainStramCollectionV)
        
        
        mainStramCollectionV.register(SubMainstreamCells.self, forCellWithReuseIdentifier: mainstreamID)
        mainStramCollectionV.register(MainstreamHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: mainstreamHeaderID)
        
        mainStramCollectionV.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        mainStramCollectionV.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        mainStramCollectionV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return (articlesArray?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let arrayArticles = articlesArray?[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainstreamID, for: indexPath) as! SubMainstreamCells
        cell.backgroundColor = .black
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 4
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shouldRasterize = false
        cell.layer.borderColor = UIColor.gray.cgColor
        
        
        cell.postedNewsDetails.text = arrayArticles?.title
        cell.postedNewsImage.sd_setImage(with: URL(string: (arrayArticles?.urlToImage)!))
        cell.authorLabel.text = arrayArticles?.author
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dates = dateFormatter.date(from: (arrayArticles?.publishedAt)!)
        cell.mainstremTimeStamp.text = dates?.timeAgoDisplay()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height / 6)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mainstreamHeaderID, for: indexPath) as! MainstreamHeaderCell
        header.backgroundColor = .white
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: frame.height / 2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let arrayArticles = articlesArray?[indexPath.item]
        self.delegate?.presentWebView(arrayArticles?.url, author: arrayArticles?.author)

    }
    
    
    func fetchArticles() {
        
        netReq.fetchArticles()
            
        
    }
    
    @objc func refreshData() {
        
        netReq.fetchArticles()
        mainStramCollectionV.reloadData()
        stopRefreshing()
        
    }
    
    func stopRefreshing() {
        
        refreshControl.endRefreshing()
    }
    
    
    

}
