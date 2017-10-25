//
//  ListInteractor.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation

protocol IListInteractor: class {
    var view: IListViewController! { get set }
    func subscribe()
    func remove(at index: Int)
    func unsubscribe()
}

final class ListInteractor: IListInteractor {
    var view: IListViewController!
    
    private lazy var geoStorageService: IGeoStorageService = inject()
    
    private var geoToken: ObserverID?
    
    deinit {
        unsubscribe()
    }
    
    func subscribe() {
        let cities = geoStorageService.cities
        view.updateCities(cities)
        
        unsubscribe()
        geoToken = geoStorageService.citiesBroadcast.addObserver { [unowned self] cities in
            self.view.updateCities(cities)
        }
    }
    
    func remove(at index: Int) {
        geoStorageService.removeCity(at: index)
    }
    
    func unsubscribe() {
        if let token = geoToken {
            geoStorageService.citiesBroadcast.removeObserver(token)
        }
    }
}
