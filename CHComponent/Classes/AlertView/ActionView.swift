//
//  ActionView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/23.
//

import UIKit

open class ActionView: UIView {

    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.highlightedTextColor = .lightText
        label.textAlignment = .center
        self.addSubview(label)
        label.frame = self.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return label
    }()
    
    open var isHighlight: Bool = false {
        didSet {
            titleLabel.isHighlighted = isHighlight
        }
    }

}
