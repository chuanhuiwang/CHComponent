//
//  ActionRepresentationsSequenceView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import UIKit

public class ActionRepresentationsSequenceView: UIScrollView {
    
    private lazy var sequenceView: SeparatableSequenceView = {
        let view = SeparatableSequenceView()
        view.frame = self.bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.heightConstraint = view.heightAnchor.constraint(equalToConstant: 0)
        self.heightConstraint?.isActive = true
        self.minimumHeightConstraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minimumHeight)
        return view
    }()
    
    var heightConstraint: NSLayoutConstraint?

    var minimumHeight: CGFloat = 66 {
        didSet {
            minimumHeightConstraint?.constant = minimumHeight
            updateMinimumHeightConstraint()
        }
    }
    var minimumHeightConstraint: NSLayoutConstraint?
    
    public private(set) var arrangedActionRepresentationViews: [ActionRepresentationView] = []
    
    public private(set) var touchedRepresentationView: ActionRepresentationView? {
        didSet {
            if touchedRepresentationView != oldValue {
                oldValue?.isHighlight = false
                touchedRepresentationView?.isHighlight = true
            }
        }
    }
    
    public var horizontalWhenTwoAction: Bool = true
    
    public func addAction(_ action: InterfaceAction) {
        let view = ActionRepresentationView(action: action)
        arrangedActionRepresentationViews.append(view)
        sequenceView.addArrangedSubview(view)
        updateSeparatableSequenceViewAxis()
        updateSeparatableSequenceViewHeight()
    }
    
    public func updateSeparatableSequenceViewHeight() {
        var height: CGFloat = 0
        if sequenceView.axis == .horizontal {
            height = arrangedActionRepresentationViews.first?.action.height ?? 0
        }else {
            height = arrangedActionRepresentationViews.reduce(0, {$0 + $1.action.height})
            height = height + sequenceView.allSeparatorViewWidth
        }
        heightConstraint?.constant = height
        updateMinimumHeightConstraint()
    }
    
    public func updateSeparatableSequenceViewAxis() {
        if arrangedActionRepresentationViews.count == 2 {
            if horizontalWhenTwoAction {
                sequenceView.axis = .horizontal
                let left = arrangedActionRepresentationViews[0]
                let right = arrangedActionRepresentationViews[1]
                let constraint = left.widthAnchor.constraint(equalTo: right.widthAnchor)
                constraint.priority = .init(200)
                constraint.isActive = true
            }else {
                sequenceView.axis = .vertical
            }
        }else {
            sequenceView.axis = .vertical
        }
    }
    
    public func updateMinimumHeightConstraint() {
        let height = heightConstraint?.constant ?? 0
        if height > minimumHeight {
            minimumHeightConstraint?.isActive = true
        }else {
            minimumHeightConstraint?.isActive = false
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedRepresentationView = findTouchedRepresentationView(touches: touches)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedRepresentationView = findTouchedRepresentationView(touches: touches)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedRepresentationView?.triggerAction()
        touchedRepresentationView = nil
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedRepresentationView = nil
    }
    
    func findTouchedRepresentationView(touches: Set<UITouch>) -> ActionRepresentationView? {
        guard let touch = touches.first else {
            return nil
        }
        let location = touch.location(in: self)
        return arrangedActionRepresentationViews.first { (view) -> Bool in
            return view.frame.contains(location)
        }
    }

}
