//
//  GTableView.swift
//  bold
//
//  Created by Afshawn Lotfi on 1/1/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class GTableView: UITableView {
    
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
    
}



class GTVDataSource<DataObject:Any>: NSObject, UITableViewDataSource{
    
    private var selectionManager:SelectionManager<DataObject>
    private var cellFormatter:ITVCellFormatter
    
    init(selectionManager : SelectionManager<DataObject>, cellFormatter : ITVCellFormatter){
        self.cellFormatter = cellFormatter
        self.selectionManager = selectionManager
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectionManager.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectionManager.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = selectionManager.items[indexPath.section][indexPath.row]
        let cell = cellFormatter.tableView(item: item, tableView: tableView, cellForRowAt: indexPath)
        return cell
    }
    
}



