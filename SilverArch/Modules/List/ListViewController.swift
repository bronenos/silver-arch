//
//  ListViewController.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

protocol IListViewController: class {
    func updateCities(_ cities: [City])
}

final class ListViewController: UIViewController, IListViewController {
    var interactor: IListInteractor!
    var router: IListRouter!
    
    private let tableView = UITableView()
    
    private var dataSource: ListDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cities"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(handleAdd)
        )
        
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.subscribe()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.unsubscribe()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = getLayout(size: view.bounds.size)
        tableView.frame = layout.tableViewFrame
    }
    
    func updateCities(_ cities: [City]) {
        dataSource?.unregister(from: tableView)
        
        dataSource = ListDataSource(cities: cities)
        dataSource?.register(in: tableView)
        
        dataSource?.deleteHandler = { [unowned self] index in
            self.interactor.remove(at: index)
        }
    }
    
    private func getLayout(size: CGSize) -> Layout {
        return Layout(
            bounds: CGRect(origin: .zero, size: size)
        )
    }
    
    @objc private func handleAdd() {
        router.presentAddCity()
    }
}

fileprivate struct Layout {
    let bounds: CGRect
    
    var tableViewFrame: CGRect {
        return bounds
    }
}
