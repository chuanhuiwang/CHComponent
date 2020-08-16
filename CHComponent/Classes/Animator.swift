//
//  Animator.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/16.
//

import Foundation


public protocol Animator {
    
    func animate(withDuration duration: TimeInterval, view: UIView)
    
}

public struct MultiAnimator: Animator {
    
    public var animator: [Animator] = []
    
    public init(animator: [Animator]) {
        self.animator = animator
    }
    
    public func animate(withDuration duration: TimeInterval, view: UIView) {
        for item in animator {
            item.animate(withDuration: duration, view: view)
        }
    }
    
}

public struct AlphaAnimator: Animator {
    
    public static let show: AlphaAnimator = .init(from: 0, to: 1)
    public static let hide: AlphaAnimator = .init(from: 1, to: 0)
    
    public let from: CGFloat
    public let to: CGFloat
    
    public init(from: CGFloat, to: CGFloat) {
        self.from = from
        self.to = to
    }
    
    public func animate(withDuration duration: TimeInterval, view: UIView) {
        view.alpha = from
        UIView.animate(withDuration: duration) {[weak view] in
            view?.alpha = self.to
        }
    }
    
}

public struct AffineTransformAnimator: Animator {
    
    public static let system: AffineTransformAnimator = .init(from: .init(scaleX: 1.16, y: 1.16), to: .init(scaleX: 1, y: 1))
    
    public let from: CGAffineTransform
    public let to: CGAffineTransform
    
    public init(from: CGAffineTransform, to: CGAffineTransform) {
        self.from = from
        self.to = to
    }
    
    public func animate(withDuration duration: TimeInterval, view: UIView) {
        view.transform = from
        UIView.animate(withDuration: duration) {[weak view] in
            view?.transform = self.to
        }
    }
    
}

public enum MoveDirection {
    case left
    case right
    case top
    case bottom
}


public struct MoveInAnimator: Animator {
    
    let direction: MoveDirection
    
    public init(_ direction: MoveDirection = .bottom) {
        self.direction = direction
    }
    
    public func animate(withDuration duration: TimeInterval, view: UIView) {
        guard let parent = view.superview else {
            return
        }
        var from = view.frame
        let to = view.frame
        switch direction {
        case .left:
            from.origin.x = parent.frame.minX - from.width
        case .right:
            from.origin.x = parent.frame.maxX
        case .top:
            from.origin.y = parent.frame.minY - from.height
        case .bottom:
            from.origin.y = parent.frame.maxY
        }
        view.frame = from
        UIView.animate(withDuration: duration) {[weak view] in
            view?.frame = to
        }
    }
    
}

public struct MoveOutAnimator: Animator {
    
    let direction: MoveDirection
    
    public init(_ direction: MoveDirection = .bottom) {
        self.direction = direction
    }
    
    public func animate(withDuration duration: TimeInterval, view: UIView) {
        guard let parent = view.superview else {
            return
        }
        var to = view.frame
        switch direction {
        case .left:
            to.origin.x = parent.frame.minX - to.width
        case .right:
            to.origin.x = parent.frame.maxX
        case .top:
            to.origin.y = parent.frame.minY - to.height
        case .bottom:
            to.origin.y = parent.frame.maxY
        }
        UIView.animate(withDuration: duration) {[weak view] in
            view?.frame = to
        }
    }
    
}
