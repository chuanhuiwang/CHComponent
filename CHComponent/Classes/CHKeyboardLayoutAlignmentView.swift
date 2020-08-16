//
//  CHKeyboardLayoutAlignmentView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/16.
//

import UIKit

public protocol CHKeyboardLayoutAlignmentViewDelegate: class {
    func keyboardLayoutAlignmentView(_ view: CHKeyboardLayoutAlignmentView, heightChanged height: CGFloat, duration: TimeInterval, curve: UInt)
}

public class CHKeyboardLayoutAlignmentView: AutoSeparatorView {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public weak var delegate: CHKeyboardLayoutAlignmentViewDelegate?
    
    override func setup() {
        super.setup()
        scaleSeparatorWidth = false
        width = 0
        NotificationCenter.default.addObserver(self, selector: #selector(CHKeyboardLayoutAlignmentView.keyboardNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let height = UIScreen.main.bounds.height - frame.minY
        width = height
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        delegate?.keyboardLayoutAlignmentView(self, heightChanged: height, duration: duration?.doubleValue ?? 0, curve: curve?.uintValue ?? 0)
    }

}
