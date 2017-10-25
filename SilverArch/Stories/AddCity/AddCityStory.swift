//
//  AddCityStory.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

func AddCityStoryAssembly() -> Module<IAddCityStory> {
    let router = AddCityStory()
    return Module<IAddCityStory>(router: router, viewController: router.viewController)
}

protocol IAddCityStory: IBaseRouter {
    func configure(didSaveHandler: @escaping () -> Void)
}

final class AddCityStory: IAddCityStory {
    private let interactor: IAddCityInteractor
    
    private var didSaveHandler: (() -> Void)?
    private weak var countryInputRouter: IInputRouter?
    private weak var nameInputRouter: IInputRouter?
    private weak var internalViewController: UINavigationController?
    
    init() {
        interactor = AddCityInteractor()
    }
    
    var viewController: UIViewController {
        if let viewController = internalViewController {
            return viewController
        }
        else {
            let nc = AddCityNavigationController()
            internalViewController = nc
            
            presentCountryInput()
            
            return nc
        }
    }
    
    func configure(didSaveHandler: @escaping () -> Void) {
        self.didSaveHandler = didSaveHandler
    }
    
    private func presentCountryInput() {
        let module = InputModuleAssembly(title: "Add city", placeholder: "Country", doneButton: "Next")
        self.countryInputRouter = module.router
        
        module.router.configure(
            doneHandler: { [unowned self] country in
                self.interactor.setCountry(country)
                self.presentNameInput()
            }
        )
        
        internalViewController?.viewControllers = [module.viewController]
    }
    
    private func presentNameInput() {
        let module = InputModuleAssembly(title: "Add city", placeholder: "Name", doneButton: "Save")
        self.nameInputRouter = module.router
        
        module.router.configure(
            doneHandler: { [unowned self] name in
                self.interactor.setName(name)
                self.interactor.save()
                
                self.didSaveHandler?()
            }
        )
        
        internalViewController?.pushViewController(module.viewController, animated: true)
    }
}

