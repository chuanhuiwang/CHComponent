//
//  AutoSeparatorView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/16.
//

import UIKit

@IBDesignable public class StyleSeparatorView: AutoSeparatorView {
    
    public enum Style: Int {
        case left
        case right
        case top
        case bottom
        case centerX
        case centerY
    }
    
    public var style: Style = .bottom {
        didSet {
            updateDirectionWithStyle()
        }
    }
    
    @IBInspectable public var styleRawValue: Int {
        get {
            return style.rawValue
        }
        set {
            if let style = Style(rawValue: newValue) {
                self.style = style
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(style: Style = .bottom) {
        self.style = style
        switch style {
        case .top, .bottom, .centerY:
            super.init(axis: .horizontal)
        default:
            super.init(axis: .vertical)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateDirectionWithStyle() {
        switch style {
        case .top, .bottom, .centerY:
            axis = .horizontal
        default:
            axis = .vertical
        }
    }
    
    override func updateSeparatorLayout() {
        super.updateSeparatorLayout()
        switch style {
        case .left:
            leftLayoutActive = true
            topLayoutActive = true
            bottomLayoutActive = true
            widthConstantLayoutActive = true
            
            rightLayoutActive = false
            centerXLayoutActive = false
            centerYLayoutActive = false
            heightConstantLayoutActive = false

        case .right:
            rightLayoutActive = true
            topLayoutActive = true
            bottomLayoutActive = true
            widthConstantLayoutActive = true

            leftLayoutActive = false
            centerXLayoutActive = false
            centerYLayoutActive = false
            heightConstantLayoutActive = false

        case .centerX:
            topLayoutActive = true
            bottomLayoutActive = true
            centerXLayoutActive = true
            widthConstantLayoutActive = true

            leftLayoutActive = false
            rightLayoutActive = false
            centerYLayoutActive = false
            heightConstantLayoutActive = false

        case .top:
            leftLayoutActive = true
            rightLayoutActive = true
            topLayoutActive = true
            heightConstantLayoutActive = true

            bottomLayoutActive = false
            centerXLayoutActive = false
            centerYLayoutActive = false
            widthConstantLayoutActive = false

        case .bottom:
            leftLayoutActive = true
            rightLayoutActive = true
            bottomLayoutActive = true
            heightConstantLayoutActive = true

            topLayoutActive = false
            centerXLayoutActive = false
            centerYLayoutActive = false
            widthConstantLayoutActive = false

        case .centerY:
            leftLayoutActive = true
            rightLayoutActive = true
            centerYLayoutActive = true
            heightConstantLayoutActive = true

            topLayoutActive = false
            bottomLayoutActive = false
            centerXLayoutActive = false
            widthConstantLayoutActive = false

        }
    }

}
