//
//  AddCityInteractor.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation

protocol IAddCityInteractor: class {
    func setCountry(_ country: String)
    func setName(_ name: String)
    func save()
}

final class AddCityInteractor: IAddCityInteractor {
    var didSaveHandler: (() -> Void)?
    
    private lazy var geoStorageService: IGeoStorageService = inject()
    
    private var country: String?
    private var name: String?
    
    func setCountry(_ country: String) {
        self.country = country
    }
    
    func setName(_ name: String) {
        self.name = name
    }
    
    func save() {
        guard let country = country, !country.isEmpty else { return }
        guard let name = name, !name.isEmpty else { return }
        
        geoStorageService.addCity(country: country, name: name)
        
        didSaveHandler?()
    }
}
