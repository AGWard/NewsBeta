//
//  KIPCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/14/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class KIPCell: BaseCell, UITableViewDelegate, UITableViewDataSource {
    
    let kipcellID = "KIPID"
    
    let kipList = ["Do not smoke indoors", "Be on time", "Buckle up", "Watch your speed", "Mind your business"]
    
    lazy var kipTableView: UITableView = {
        
        let tview = UITableView()
        tview.translatesAutoresizingMaskIntoConstraints = false
        tview.delegate = self
        tview.dataSource = self
    
        
        
        return tview
        
    }()

 
    
    override func setupViews() {

        kipTableViewConstraints()
        
    }
    
    
    func kipTableViewConstraints() {
        
        addSubview(kipTableView)
        
        kipTableView.frame = contentView.frame
        kipTableView.register(KIPHistoryCell.self, forCellReuseIdentifier: kipcellID)
        
        kipTableView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        kipTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        kipTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return kipList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kipcellID, for: indexPath) as! KIPHistoryCell
        
        cell.textLabel?.text = kipList[indexPath.item]
        
        
        return cell
    }
    

    

}
