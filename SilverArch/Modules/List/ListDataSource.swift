//
//  ListDataSource.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

final class ListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var deleteHandler: ((Int) -> Void)?
    
    private let cities: [City]
    
    init(cities: [City]) {
        self.cities = cities
    }
    
    func register(in tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.reloadData()
    }
    
    func unregister(from tableView: UITableView) {
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteHandler?(indexPath.row)
    }
}
