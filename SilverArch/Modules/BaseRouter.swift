//
//  BaseRouter.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import UIKit

protocol IBaseRouter: class {
    var viewController: UIViewController { get }
}

struct Module<RT> {
    let router: RT
    let viewController: UIViewController
}

