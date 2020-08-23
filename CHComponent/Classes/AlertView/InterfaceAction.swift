//
//  InterfaceAction.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import Foundation


public class InterfaceAction {
    
    public let view: ActionView
    public let handler: (InterfaceAction) -> Void
    public var height: CGFloat = 44 {
        didSet {
            representationView?.heightConstraint?.constant = height
            representationsSequenceView?.updateSeparatableSequenceViewHeight()
        }
    }
    weak var representationView: ActionRepresentationView?
    weak var representationsSequenceView: ActionRepresentationsSequenceView?
    
    public init(view: ActionView, handler: @escaping (InterfaceAction) -> Void) {
        self.view = view
        self.handler = handler
    }
    
    public init(title: String, handler: @escaping (InterfaceAction) -> Void) {
        let view = ActionView()
        view.titleLabel.text = title
        self.view = view
        self.handler = handler
    }
    
    func triggerAction() {
        
    }
    
}
