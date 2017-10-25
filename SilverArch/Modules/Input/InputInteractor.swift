//
//  InputInteractor.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation

protocol IInputInteractor: class {
    var view: IInputViewController! { get set }
}

final class InputInteractor: IInputInteractor {
    var view: IInputViewController!
}

