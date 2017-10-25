//
//  ListRouter.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

func ListModuleAssembly() -> Module<IListRouter> {
    let router = ListRouter()
    return Module<IListRouter>(router: router, viewController: router.viewController)
}

protocol IListRouter: IBaseRouter {
    func presentAddCity()
}

final class ListRouter: IListRouter {
    let interactor: IListInteractor
    private weak var internalViewController: IListViewController?
    
    private weak var addCityStory: IAddCityStory?
    
    init() {
        interactor = ListInteractor()
    }
    
    var viewController: UIViewController {
        if let _ = internalViewController {
            return internalViewController as! UIViewController
        }
        else {
            let vc = ListViewController()
            vc.router = self
            vc.interactor = interactor
            internalViewController = vc
            
            interactor.view = vc
            
            return vc
        }
    }
    
    func presentAddCity() {
        let module = AddCityStoryAssembly()
        addCityStory = module.router
        
        module.router.configure(
            didSaveHandler: { [unowned self] in
                module.viewController.dismiss(animated: true, completion: nil)
            }
        )
        
        viewController.present(module.viewController, animated: true, completion: nil)
    }
}

