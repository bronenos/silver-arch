//
//  RootRouter.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

func RootModuleAssembly(window: UIWindow) -> Module<IRootRouter> {
    let router = RootRouter(window: window)
    return Module<IRootRouter>(router: router, viewController: router.viewController)
}

protocol IRootRouter: IBaseRouter {
}

final class RootRouter: IRootRouter {
    private weak var internalViewController: UIViewController?
    
    private weak var listRouter: IListRouter?
    
    init(window: UIWindow) {
        let serviceLocator = ServiceLocator(
            geoStorage: GeoStorageService()
        )
        
        serviceLocator.prepareInjections()
    }
    
    var viewController: UIViewController {
        if let viewController = internalViewController {
            return viewController
        }
        else {
            let module = ListModuleAssembly()
            listRouter = module.router
            
            let nc = UINavigationController(rootViewController: module.viewController)
            internalViewController = nc
            
            return nc
        }
    }
}
