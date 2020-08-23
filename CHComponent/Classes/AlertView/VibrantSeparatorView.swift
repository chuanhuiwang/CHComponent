//
//  VibrantSeparatorView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import UIKit


@IBDesignable public class VibrantSeparatorView: AutoSeparatorView {
    
    
    public var effect: UIVisualEffect {
        didSet {
            visualEffectView.effect = effect
        }
    }
    lazy var visualEffectView: UIVisualEffectView = .init(effect: self.effect)
    
    public override init(frame: CGRect) {
        if #available(iOS 13.0, *) {
            self.effect = UIVibrancyEffect(blurEffect: .init(style: .regular), style: .separator)
        } else {
            self.effect = UIVibrancyEffect(blurEffect: .init(style: .regular))
        }
        super.init(frame: frame)
    }
    
    public init(effect: UIVisualEffect) {
        self.effect = effect
        super.init(axis: .horizontal, width: 1)
    }
    
    public required init?(coder: NSCoder) {
        if #available(iOS 13.0, *) {
            self.effect = UIVibrancyEffect(blurEffect: .init(style: .regular), style: .separator)
        } else {
            self.effect = UIVibrancyEffect(blurEffect: .init(style: .regular))
        }
        super.init(coder: coder)
    }
    
    override func setup() {
        super.setup()
        addSubview(visualEffectView)
        visualEffectView.frame = bounds
        visualEffectView.contentView.backgroundColor = .white
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
}


extension VibrantSeparatorView: SeparatableSequenceSeparatorProtocol {
    
    public var separatorWidth: CGFloat {
        return width / scale
    }
    
    public func separatableSequenceView(_ view: SeparatableSequenceView, axisChanged axis: NSLayoutConstraint.Axis) {
        if axis == .horizontal {
            self.axis = .vertical
        }else {
            self.axis = .horizontal
        }
    }
}
