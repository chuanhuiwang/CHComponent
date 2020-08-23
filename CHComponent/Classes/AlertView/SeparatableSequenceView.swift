//
//  SeparatableSequenceView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import UIKit

public protocol SeparatableSequenceSeparatorProtocol {
    var separatorWidth: CGFloat {get}
    func separatableSequenceView(_ view: SeparatableSequenceView, axisChanged axis: NSLayoutConstraint.Axis)
}

public protocol SeparatableSequenceSeparatorCreator {
    func createSeparatorView(_ view: SeparatableSequenceView, axis: NSLayoutConstraint.Axis) -> SeparatableSequenceView.SeparatorView
}

@IBDesignable public class SeparatableSequenceView: UIView {
    
    public typealias SeparatorView = UIView & SeparatableSequenceSeparatorProtocol

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        self.addSubview(stack)
        stack.frame = self.bounds
        stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return stack
    }()
    
    public var axis: NSLayoutConstraint.Axis {
        get {
            return  stackView.axis
        }
        set {
            if stackView.axis == newValue {
                return
            }
            stackView.axis = newValue
            arrangedContentSeparatorViews.forEach({$0.separatableSequenceView(self, axisChanged: axis)})
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
    
    public var distribution: UIStackView.Distribution {
        get {
            return stackView.distribution
        }
        set {
            stackView.distribution = newValue
        }
    }
    
    @IBInspectable public var distributionRawValue: Int {
        get {
            return stackView.distribution.rawValue
        }
        set {
            if let value = UIStackView.Distribution(rawValue: newValue) {
                distribution = value
            }
        }
    }
    
    public private(set) var arrangedContentViews: [UIView] = []
    public private(set) var arrangedContentSeparatorViews: [SeparatorView] = []
    
    public var allSeparatorViewWidth: CGFloat {
        return arrangedContentSeparatorViews.reduce(0, {$0 + $1.separatorWidth})
    }
    
    public var separatorViewCreator: SeparatableSequenceSeparatorCreator = VibrantSeparatorViewCeator()
    
    public func createContentSeparatorView() -> SeparatorView {
        return separatorViewCreator.createSeparatorView(self, axis: axis)
    }
    
    public func addArrangedSubview(_ view: UIView) {
        if arrangedContentViews.isEmpty == false {
            let separator = createContentSeparatorView()
            arrangedContentSeparatorViews.append(separator)
            stackView.addArrangedSubview(separator)
        }
        arrangedContentViews.append(view)
        stackView.addArrangedSubview(view)
    }
    
}


public extension SeparatableSequenceView {
    
    struct VibrantSeparatorViewCeator: SeparatableSequenceSeparatorCreator {
        public func createSeparatorView(_ view: SeparatableSequenceView, axis: NSLayoutConstraint.Axis) -> SeparatableSequenceView.SeparatorView {
            let result = VibrantSeparatorView(frame: .zero)
            result.separatableSequenceView(view, axisChanged: axis)
            return result
        }
    }
    
}
