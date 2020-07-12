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
    
    @IBOutlet var button: CHButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(button?.frame)
        button?.sizeToFit()
        print(button?.frame)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(button?.frame)
        button?.sizeToFit()
        print(button?.frame)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            var frame = self.button?.frame ?? CGRect.zero
            frame.origin.x = 0
            frame.size.width = self.view.frame.width
            self.button?.frame = frame
            self.button?.sizeToFit()
            print(self.button?.frame)
        }
    }
    
}
