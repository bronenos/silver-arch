//
//  ServiceLocator.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

fileprivate var injections = [String: Any]()

struct ServiceLocator {
    let geoStorage: IGeoStorageService
    
    func prepareInjections() {
        prepareInjection(geoStorage)
    }
}

func inject<T>() -> T! {
    let key = String(describing: T.self)
    return injections[key] as? T
}

fileprivate func prepareInjection<T: Any>(_ injection: T) {
    let key = String(describing: T.self)
    injections[key] = injection
}

