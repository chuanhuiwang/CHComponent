//
//  AutoSeparatorView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import UIKit

@IBDesignable public class AutoSeparatorView: AutoLayoutView {
    
    public var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            updateSeparatorLayout()
        }
    }
    
    @IBInspectable public var axisRawValue: Int {
        get {
            return axis.rawValue
        }
        set {
            if let value = NSLayoutConstraint.Axis(rawValue: newValue) {
                axis = value
            }
        }
    }
    
    @IBInspectable public var scaleSeparatorWidth: Bool {
        get {
            return useScreenScale
        }
        set {
            useScreenScale = newValue
        }
    }
    
    @IBInspectable public var width: CGFloat = 1 {
        didSet {
            widthConstantLayoutConstant = width
            heightConstantLayoutConstant = width
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(axis: NSLayoutConstraint.Axis, width: CGFloat = 1) {
        self.axis = axis
        self.width = width
        super.init(frame: .zero)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        useScreenScale = true
        widthConstantLayoutConstant = width
        heightConstantLayoutConstant = width
        updateSeparatorLayout()
    }
    
    func updateSeparatorLayout() {
        widthLayoutActive = false
        heightLayoutActive = false
        switch axis {
        case .horizontal:
            widthConstantLayoutActive = false
            heightConstantLayoutActive = true

        case .vertical:
            widthConstantLayoutActive = true
            heightConstantLayoutActive = false
        @unknown default:
            ()
        }
    }

}

