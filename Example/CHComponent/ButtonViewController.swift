//
//  ButtonViewController.swift
//  CHComponent_Example
//
//  Created by 王传辉 on 2020/6/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CHComponent

class ButtonViewController: UIViewController {
    
    let button = CHButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        button.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        button.backgroundColor = .orange
        button.setTitle("Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .black)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(button)
//        self.button.translatesAutoresizingMaskIntoConstraints = false
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.button.contentDirection = .bottomToTop
            self.button.spacing = 20
            self.button.imageScale = 3
            self.button.titleLabel?.font = .systemFont(ofSize: 50, weight: .black)
            self.button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
            self.button.sizeToFit()
        }
    }
    
}
