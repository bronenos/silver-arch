//
//  InputViewController.swift
//  SilverArch
//
//  Created by Stan Potemkin on 22/10/2017.
//  Copyright © 2017 bronenos. All rights reserved.
//

import Foundation
import UIKit

protocol IInputViewController: class {
    var doneHandler: ((String) -> Void)? { get set }
}

final class InputViewController: UIViewController, IInputViewController {
    var doneHandler: ((String) -> Void)?
    
    var interactor: IInputInteractor!
    var router: IInputRouter!
    
    private let textField = UITextField()
    
    init(title: String, placeholder: String, doneButton: String) {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: doneButton,
            style: .plain,
            target: self,
            action: #selector(handleDone)
        )
        
        textField.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = getLayout(size: view.bounds.size)
        textField.frame = layout.textFieldFrame
    }
    
    private func getLayout(size: CGSize) -> Layout {
        return Layout(
            bounds: CGRect(origin: .zero, size: size),
            topLayoutGuide: topLayoutGuide
        )
    }
    
    @objc private func handleDone() {
        guard let text = textField.text, !text.isEmpty else { return }
        doneHandler?(text)
    }
}

fileprivate struct Layout {
    let bounds: CGRect
    let topLayoutGuide: UILayoutSupport
    
    var textFieldFrame: CGRect {
        return bounds
            .offsetBy(dx: 0, dy: topLayoutGuide.length + 20)
            .insetBy(dx: 10, dy: 0)
            .divided(atDistance: 30, from: .minYEdge).slice
    }
}

