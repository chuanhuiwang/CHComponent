//
//  AutoLayoutView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/15.
//

import UIKit

@IBDesignable public class AutoLayoutView: UIView {
    
    @IBInspectable public var useSafeArea: Bool = false {
        didSet {
            if useSafeArea == oldValue {
                return
            }
            updateAllLayout()
            if useSafeArea {
                superview?.itSelfLayoutGuide.removeFromOwiningView()
            }
        }
    }
    
    public var parentLayoutGuide: UILayoutGuide? {
        if useSafeArea {
            if #available(iOS 11.0, *) {
                return superview?.safeAreaLayoutGuide
            } else {
                return superview?.layoutMarginsGuide
            }
        }else {
            return superview?.itSelfLayoutGuide
        }
    }
    
    weak var leftLayout: NSLayoutConstraint?
    
    @IBInspectable public var leftLayoutActive: Bool = false {
        didSet {
            leftLayoutUpdate()
        }
    }
    
    @IBInspectable public var leftLayoutConstant: CGFloat = 0 {
        didSet {
            leftLayoutUpdate()
        }
    }
    
    func leftLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if leftLayout == nil, leftLayoutActive, let parent = parentLayoutGuide {
            leftLayout = leftAnchor.constraint(equalTo: parent.leftAnchor)
        }
        leftLayout?.isActive = leftLayoutActive
        leftLayout?.constant = leftLayoutConstant
    }
    
    
    weak var rightLayout: NSLayoutConstraint?
    
    @IBInspectable public var rightLayoutActive: Bool = false {
        didSet {
            rightLayoutUpdate()
        }
    }
    
    @IBInspectable public var rightLayoutConstant: CGFloat = 0 {
        didSet {
            rightLayoutUpdate()
        }
    }
    
    func rightLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if rightLayout == nil, rightLayoutActive, let parent = parentLayoutGuide {
            rightLayout = rightAnchor.constraint(equalTo: parent.rightAnchor)
        }
        rightLayout?.isActive = rightLayoutActive
        rightLayout?.constant = rightLayoutConstant
    }

    
    weak var topLayout: NSLayoutConstraint?
    
    @IBInspectable public var topLayoutActive: Bool = false {
        didSet {
            topLayoutUpdate()
        }
    }
    
    @IBInspectable public var topLayoutConstant: CGFloat = 0 {
        didSet {
            topLayoutUpdate()
        }
    }
    
    func topLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if topLayout == nil, topLayoutActive, let parent = parentLayoutGuide {
            topLayout = topAnchor.constraint(equalTo: parent.topAnchor)
        }
        topLayout?.isActive = topLayoutActive
        topLayout?.constant = topLayoutConstant
    }
    
    
    weak var bottomLayout: NSLayoutConstraint?
    
    @IBInspectable public var bottomLayoutActive: Bool = false {
        didSet {
            bottomLayoutUpdate()
        }
    }
    
    @IBInspectable public var bottomLayoutConstant: CGFloat = 0 {
        didSet {
            bottomLayoutUpdate()
        }
    }
    
    func bottomLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if bottomLayout == nil, bottomLayoutActive, let parent = parentLayoutGuide {
            bottomLayout = bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        }
        bottomLayout?.isActive = bottomLayoutActive
        bottomLayout?.constant = bottomLayoutConstant
    }
    
    
    weak var centerXLayout: NSLayoutConstraint?
    
    @IBInspectable public var centerXLayoutActive: Bool = false {
        didSet {
            centerXLayoutUpdate()
        }
    }
    
    @IBInspectable public var centerXLayoutMultiplier: CGFloat = 1 {
        didSet {
            centerXLayout?.isActive = false
            centerXLayout = nil
            centerXLayoutUpdate()
        }
    }
    
    @IBInspectable public var centerXLayoutConstant: CGFloat = 0 {
        didSet {
            centerXLayoutUpdate()
        }
    }
    
    func centerXLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if centerXLayout == nil, centerXLayoutActive, let parent = parentLayoutGuide {
            centerXLayout = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: parent, attribute: .centerX, multiplier: centerXLayoutMultiplier, constant: centerXLayoutConstant)
        }
        centerXLayout?.isActive = centerXLayoutActive
        centerXLayout?.constant = centerXLayoutConstant
    }

    
    weak var centerYLayout: NSLayoutConstraint?
    
    @IBInspectable public var centerYLayoutActive: Bool = false {
        didSet {
            centerYLayoutUpdate()
        }
    }
    
    @IBInspectable public var centerYLayoutMultiplier: CGFloat = 1 {
        didSet {
            centerYLayout?.isActive = false
            centerYLayout = nil
            centerYLayoutUpdate()
        }
    }
    
    @IBInspectable public var centerYLayoutConstant: CGFloat = 0 {
        didSet {
            centerYLayoutUpdate()
        }
    }
    
    func centerYLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if centerYLayout == nil, centerYLayoutActive, let parent = parentLayoutGuide {
            centerYLayout = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: parent, attribute: .centerY, multiplier: centerYLayoutMultiplier, constant: centerYLayoutConstant)
        }
        centerYLayout?.isActive = centerYLayoutActive
        centerYLayout?.constant = centerYLayoutConstant
    }
    

    weak var widthLayout: NSLayoutConstraint?
    
    @IBInspectable public var widthLayoutActive: Bool = false {
        didSet {
            widthLayoutUpdate()
        }
    }
    
    @IBInspectable public var widthLayoutMultiplier: CGFloat = 1 {
        didSet {
            widthLayout?.isActive = false
            widthLayout = nil
            widthLayoutUpdate()
        }
    }
    
    @IBInspectable public var widthLayoutConstant: CGFloat = 0 {
        didSet {
            widthLayoutUpdate()
        }
    }
    
    func widthLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if widthLayout == nil, widthLayoutActive, let parent = parentLayoutGuide {
            widthLayout = widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: widthLayoutMultiplier)
        }
        widthLayout?.isActive = widthLayoutActive
        widthLayout?.constant = widthLayoutConstant
    }
    
    
    weak var heightLayout: NSLayoutConstraint?
    
    @IBInspectable public var heightLayoutActive: Bool = false {
        didSet {
            heightLayoutUpdate()
        }
    }
    
    @IBInspectable public var heightLayoutMultiplier: CGFloat = 1 {
        didSet {
            heightLayout?.isActive = false
            heightLayout = nil
            heightLayoutUpdate()
        }
    }
    
    @IBInspectable public var heightLayoutConstant: CGFloat = 0 {
        didSet {
            heightLayoutUpdate()
        }
    }
    
    func heightLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if heightLayout == nil, heightLayoutActive, let parent = parentLayoutGuide {
            heightLayout = heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: heightLayoutMultiplier)
        }
        heightLayout?.isActive = heightLayoutActive
        heightLayout?.constant = heightLayoutConstant
    }
    
    @IBInspectable public var useScreenScale: Bool = false {
        didSet {
            widthConstantLayoutUpdate()
            heightConstantLayoutUpdate()
        }
    }
    
    public var scale: CGFloat {
        if useScreenScale {
            return UIScreen.main.scale
        }else {
            return 1
        }
    }
    
    
    weak var widthConstantLayout: NSLayoutConstraint?
    
    @IBInspectable public var widthConstantLayoutActive: Bool = false {
        didSet {
            widthConstantLayoutUpdate()
        }
    }
    
    @IBInspectable public var widthConstantLayoutConstant: CGFloat = 0 {
        didSet {
            widthConstantLayoutUpdate()
        }
    }
    
    func widthConstantLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if widthConstantLayout == nil, widthConstantLayoutActive {
            widthConstantLayout = widthAnchor.constraint(equalToConstant: widthConstantLayoutConstant / scale)
        }
        widthConstantLayout?.isActive = widthConstantLayoutActive
        widthConstantLayout?.constant = widthConstantLayoutConstant / scale
    }
    
    
    weak var heightConstantLayout: NSLayoutConstraint?
    
    @IBInspectable public var heightConstantLayoutActive: Bool = false {
        didSet {
            heightConstantLayoutUpdate()
        }
    }
    
    @IBInspectable public var heightConstantLayoutConstant: CGFloat = 0 {
        didSet {
            heightConstantLayoutUpdate()
        }
    }
    
    func heightConstantLayoutUpdate() {
        translatesAutoresizingMaskIntoConstraints = false
        if heightConstantLayout == nil, heightConstantLayoutActive {
            heightConstantLayout = heightAnchor.constraint(equalToConstant: heightConstantLayoutConstant / scale)
        }
        heightConstantLayout?.isActive = heightConstantLayoutActive
        heightConstantLayout?.constant = heightConstantLayoutConstant / scale
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        updateAllLayout()
    }
    
    func updateAllLayout() {
        leftLayout?.isActive = false
        rightLayout?.isActive = false
        topLayout?.isActive = false
        bottomLayout?.isActive = false
        centerXLayout?.isActive = false
        centerYLayout?.isActive = false
        widthLayout?.isActive = false
        heightLayout?.isActive = false
        widthConstantLayout?.isActive = false
        heightConstantLayout?.isActive = false
        
        leftLayout = nil
        rightLayout = nil
        topLayout = nil
        bottomLayout = nil
        centerXLayout = nil
        centerYLayout = nil
        widthLayout = nil
        heightLayout = nil
        widthConstantLayout = nil
        heightConstantLayout = nil
        
        leftLayoutUpdate()
        rightLayoutUpdate()
        topLayoutUpdate()
        bottomLayoutUpdate()
        centerXLayoutUpdate()
        centerYLayoutUpdate()
        widthLayoutUpdate()
        heightLayoutUpdate()
        widthConstantLayoutUpdate()
        heightConstantLayoutUpdate()
    }
    
}


