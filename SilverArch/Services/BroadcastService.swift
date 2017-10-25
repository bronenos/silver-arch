//
//  BroadcastService.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation

typealias ObserverID = UUID

class BroadcastService<VT> {
    typealias Observer = (VT) -> Void
    
    private var observers = [UUID: Observer]()
    
    func addObserver(_ observer: @escaping Observer) -> ObserverID {
        let id = UUID()
        observers[id] = observer
        return id
    }
    
    func removeObserver(_ id: UUID) {
        observers.removeValue(forKey: id)
    }
    
    func broadcast(_ value: VT) {
        observers.values.forEach { observer in
            observer(value)
        }
    }
}
