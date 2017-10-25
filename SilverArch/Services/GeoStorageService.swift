//
//  GeoStorageService.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation

struct City {
    let country: String
    let name: String
}

protocol IGeoStorageService: class {
    var cities: [City] { get }
    var citiesBroadcast: BroadcastService<[City]> { get }
    func addCity(country: String, name: String)
    func removeCity(at index: Int)
}

final class GeoStorageService: IGeoStorageService {
    private(set) var cities = [City]()
    let citiesBroadcast = BroadcastService<[City]>()
    
    init() {
        cities = [
            City(country: "Russia", name: "Moscow"),
            City(country: "Ukraine", name: "Kiev"),
            City(country: "USA", name: "Los Angeles")
        ]
    }
    
    func addCity(country: String, name: String) {
        let city = City(country: country, name: name)
        cities.append(city)
        citiesBroadcast.broadcast(cities)
    }
    
    func removeCity(at index: Int) {
        cities.remove(at: index)
        citiesBroadcast.broadcast(cities)
    }
}
