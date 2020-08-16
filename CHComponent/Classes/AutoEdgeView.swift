//
//  AutoEdgeView.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/8/16.
//

import UIKit

@IBDesignable public class AutoEdgeView: AutoLayoutView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        leftLayoutActive = true
        rightLayoutActive = true
        topLayoutActive = true
        bottomLayoutActive = true
    }

}
