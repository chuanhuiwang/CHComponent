//
//  ActionRepresentationView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import UIKit

public class ActionRepresentationView: UIView {

    public let action: InterfaceAction
    lazy var visualEffectView: UIVisualEffectView = {
        let effect: UIVisualEffect
        if #available(iOS 13.0, *) {
            effect = UIVibrancyEffect(blurEffect: .init(style: .regular), style: .separator)
        } else {
            effect = UIVibrancyEffect(blurEffect: .init(style: .regular))
        }
        let view = UIVisualEffectView(effect: effect)
        view.contentView.backgroundColor = .white
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    var heightConstraint: NSLayoutConstraint?
    weak var widthConstraint: NSLayoutConstraint?
    
    public var isHighlight: Bool = false {
        didSet {
            if isHighlight != oldValue {
                highlightChanged()
            }
        }
    }
    
    public init(action: InterfaceAction) {
        self.action = action
        super.init(frame: .zero)
        heightConstraint = heightAnchor.constraint(equalToConstant: action.height)
        heightConstraint?.isActive = true
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(action.view)
        action.view.frame = bounds
        action.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func highlightChanged() {
        visualEffectView.isHidden = !isHighlight
        action.view.isHighlight = isHighlight
    }
    
    func widthConstraintActive(_ active: Bool, width: CGFloat) {
        if active {
            widthConstraint?.isActive = false
            widthConstraint = widthAnchor.constraint(equalToConstant: width)
            widthConstraint?.isActive = true
        }else {
            widthConstraint?.isActive = false
        }
    }
    
    func triggerAction() {
        action.triggerAction()
    }

}
