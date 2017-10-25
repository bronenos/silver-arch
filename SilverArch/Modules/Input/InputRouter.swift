//
//  InputRouter.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

func InputModuleAssembly(title: String, placeholder: String, doneButton: String) -> Module<IInputRouter> {
    let router = InputRouter(title: title, placeholder: placeholder, doneButton: doneButton)
    return Module<IInputRouter>(router: router, viewController: router.viewController)
}

protocol IInputRouter: IBaseRouter {
    func configure(doneHandler: @escaping (String) -> ())
}

final class InputRouter: IInputRouter {
    private let title: String
    private let placeholder: String
    private let doneButton: String
    
    let interactor: IInputInteractor
    private weak var internalViewController: IInputViewController?
    
    init(title: String, placeholder: String, doneButton: String) {
        self.title = title
        self.placeholder = placeholder
        self.doneButton = doneButton
        
        interactor = InputInteractor()
    }
    
    var viewController: UIViewController {
        if let _ = internalViewController {
            return internalViewController as! UIViewController
        }
        else {
            let vc = InputViewController(title: title, placeholder: placeholder, doneButton: doneButton)
            vc.router = self
            vc.interactor = interactor
            internalViewController = vc
            
            interactor.view = vc
            
            return vc
        }
    }
    
    func configure(doneHandler: @escaping (String) -> ()) {
        internalViewController?.doneHandler = doneHandler
    }
}
