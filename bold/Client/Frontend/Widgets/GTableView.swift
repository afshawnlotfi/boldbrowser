//
//  GTableView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/1/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

import UIKit

class GTableView: UITableView,UITableViewDelegate {
    
    private(set) var identifier = "GTableViewCell"
    
    init(identifier : String? = nil) {
        super.init(frame: CGRect.zero, style: .plain)

        self.register(UINib(nibName: identifier ?? self.identifier, bundle: nil), forCellReuseIdentifier: identifier ?? self.identifier)
        self.backgroundColor = .clear
        self.separatorColor = .clear
    }
    
   
    
    required convenience init(coder: NSCoder) {
        self.init(identifier : "GTableViewCell")
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//
//    }
    
    
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let screenSize = UIScreen.main.bounds
//
//        return 0.3*screenSize.height
//    }
//
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
//
    
    
    
}
