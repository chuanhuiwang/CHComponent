//
//  ViewController.swift
//  CHComponent
//
//  Created by 372020909@qq.com on 06/25/2020.
//  Copyright (c) 2020 372020909@qq.com. All rights reserved.
//

import UIKit
import CHComponent

class RootView: UIView, CHTransitionViewRootView {
    var transitionViewWrapper: CHTransitionViewWrapper?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    func hideByTapBackgroundView(transitionView: CHTransitionView) {
        print(transitionView)
    }
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (_) in

        }))
//        alert.addTextField { (textfield) in
//
//        }
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive destructive destructive destructive destructive destructive destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in
//
//        }))
//        alert.addAction(UIAlertAction(title: "default", style: .default, handler: { (_) in
//
//        }))
        alert.addAction(UIAlertAction(title: "destructive", style: .destructive, handler: { (_) in

        }))
        present(alert, animated: true, completion: { () in
//            alert.dismiss(animated: true, completion: nil)
        })
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            alert.dismiss(animated: true, completion: nil)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let root = RootView()
        root.backgroundColor = .orange
        let transition = CHTransitionView(rootView: root)
//        transition.animateDuration = 3
//        transition.showAnimator = MoveInAnimator(.bottom)
//        transition.hideAnimator = MoveOutAnimator(.bottom)
        transition.canHideWhenTapBackgroundView = true
        
        root.translatesAutoresizingMaskIntoConstraints = false
        root.centerXAnchor.constraint(equalTo: transition.contentView.centerXAnchor).isActive = true
        root.centerYAnchor.constraint(equalTo: transition.contentView.centerYAnchor).isActive = true
        root.widthAnchor.constraint(equalToConstant: 200).isActive = true
        root.heightAnchor.constraint(equalToConstant: 200).isActive = true

        transition.show()
        
        
//        self.view.subviews.forEach { (item) in
//            if let textfield = item as? UITextField {
//                textfield.becomeFirstResponder()
//            }
//        }
        
        transition.delayHide(3)
        transition.cancelDelayHide()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

