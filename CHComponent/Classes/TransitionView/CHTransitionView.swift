//
//  CHTransitionView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/16.
//

import UIKit

public protocol CHTransitionViewRootView {
    var transitionViewWrapper: CHTransitionViewWrapper? {get set}
    func hideByTapBackgroundView(transitionView: CHTransitionView)
}

public extension CHTransitionViewRootView {
    func hideByTapBackgroundView(transitionView: CHTransitionView) {
        
    }
}

public struct CHTransitionViewWrapper {
    weak var transitionView: CHTransitionView?
}

public class CHTransitionView: UIView {
    
    public enum Status {
        case hidden
        case showing
        case showed
        case hiding
    }

    let control: UIControl = .init()
    public var backgroundView: UIView {control}
    public let contentView: AutoLayoutView = AutoLayoutView()
    public let keyboardView: CHKeyboardLayoutAlignmentView = .init()
    public let rootView: UIView
    
    var status: Status = .hidden
    
    public var backgroundColorWhenShow: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    public var backgroundColorWhenHidden: UIColor = .clear
    public var animateDuration: TimeInterval = 0.25
    public var showAnimator: Animator = MultiAnimator(animator: [AffineTransformAnimator.system, AlphaAnimator.show])
    public var hideAnimator: Animator = AlphaAnimator.hide
    
    public var canHideWhenTapBackgroundView: Bool = true
    
    var delayHideTimer: Timer?
    
    public init(rootView: UIView) {
        self.rootView = rootView
        super.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        delayHideTimer?.invalidate()
    }
    
    func setup() {
        
        control.addTarget(self, action: #selector(CHTransitionView.tapBackgroundView), for: .touchUpInside)
        control.isUserInteractionEnabled = false
        addSubview(control)
        control.frame = bounds
        control.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        keyboardView.isUserInteractionEnabled = false
        keyboardView.delegate = self
        addSubview(keyboardView)
        
        addSubview(contentView)
        contentView.leftLayoutActive = true
        contentView.rightLayoutActive = true
        contentView.topLayoutActive = true
        contentView.isUserInteractionEnabled = false
        contentView.bottomAnchor.constraint(equalTo: keyboardView.topAnchor).isActive = true
        
        if var rootViewProtocol = rootView as? CHTransitionViewRootView {
            rootViewProtocol.transitionViewWrapper = .init(transitionView: self)
        }
        
        addSubview(rootView)
    }
    
    public func show(in view: UIView) {
        view.addSubview(self)
        self.frame = view.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.layoutIfNeeded()
        rootView.didMoveToSuperview()
        
        if status != .hidden {
            return
        }
        status = .showing
        
        self.backgroundView.backgroundColor = self.backgroundColorWhenHidden
        UIView.animate(withDuration: animateDuration, animations: {[weak self] () in
            self?.backgroundView.backgroundColor = self?.backgroundColorWhenShow
        }) {[weak self] (_) in
            self?.status = .showed
            self?.backgroundView.isUserInteractionEnabled = true
        }
        showAnimator.animate(withDuration: animateDuration, view: rootView)
    }
    
    public func show() {
        let application = UIApplication.shared
        if let window = application.keyWindow {
            show(in: window)
        }else if let window = application.windows.first {
            show(in: window)
        }
    }
    
    public func hide() {
        if status != .showed {
            return
        }
        cancelDelayHide()
        status = .hiding
        self.backgroundView.isUserInteractionEnabled = false
        UIView.animate(withDuration: animateDuration, animations: {[weak self] in
            self?.backgroundView.backgroundColor = self?.backgroundColorWhenHidden
        }) {[weak self] (_) in
            self?.removeFromSuperview()
            self?.status = .hidden
        }
        hideAnimator.animate(withDuration: animateDuration, view: rootView)
    }
    
    public func delayHide(_ duration: TimeInterval) {
        delayHideTimer?.invalidate()
        delayHideTimer = .scheduledTimer(withTimeInterval: duration, repeats: false, block: {[weak self] (timer) in
            self?.hide()
        })
    }
    
    public func cancelDelayHide() {
        delayHideTimer?.invalidate()
        delayHideTimer = nil
    }
    
    @objc func tapBackgroundView() {
        if canHideWhenTapBackgroundView {
            hide()
            if let root = rootView as? CHTransitionViewRootView {
                root.hideByTapBackgroundView(transitionView: self)
            }
        }
    }

}


extension CHTransitionView: CHKeyboardLayoutAlignmentViewDelegate {
    public func keyboardLayoutAlignmentView(_ view: CHKeyboardLayoutAlignmentView, heightChanged height: CGFloat, duration: TimeInterval, curve: UInt) {
        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {[weak self] in
            self?.layoutIfNeeded()
        }) { (_) in
            
        }
    }
}
