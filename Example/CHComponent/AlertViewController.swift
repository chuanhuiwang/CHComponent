//
//  AlertViewController.swift
//  CHComponent_Example
//
//  Created by 王传辉 on 2020/8/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CHComponent

class AlertViewController: UIViewController {
    
    let sequence: ActionRepresentationsSequenceView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(sequence)
        sequence.frame = view.bounds
        sequence.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sequence.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        addAction()
        addAction()
        addAction()
        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()
//        addAction()

    }
    
    func addAction() {
        sequence.addAction(.init(title: "title", handler: { (action) in
            print(action)
        }))
    }

}
