//
//  ItSelfLayoutGuide.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/15.
//

import Foundation


public class ItSelfLayoutGuide: UILayoutGuide {
    
    public override var owningView: UIView? {
        didSet {
            if let view = owningView {
                self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            }
        }
    }
    
    public func removeFromOwiningView() {
        owningView?.removeLayoutGuide(self)
    }
    
}


public extension UIView {
    
    var itSelfLayoutGuide: ItSelfLayoutGuide {
        if let result = layoutGuides.first(where: {$0 is ItSelfLayoutGuide}) {
            return result as! ItSelfLayoutGuide
        }
        let result = ItSelfLayoutGuide()
        self.addLayoutGuide(result)
        return result
    }
    
}
