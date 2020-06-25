//
//  CHButton.swift
//  CHComponent
//
//  Created by 王传辉 on 2020/6/25.
//

import UIKit

@IBDesignable public class CHButton: UIButton {
    
    public enum ContentDirection {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
    }
    
    @IBInspectable public var contentDirectionRawValue: Int {
        get {
            let dic: [ContentDirection: Int] = [.leftToRight: 0, .rightToLeft: 1, .topToBottom: 2, .bottomToTop: 3]
            return dic[contentDirection] ?? 0
        }
        set {
            let dic: [Int: ContentDirection] = [0: .leftToRight, 1: .rightToLeft, 2: .topToBottom, 3: .bottomToTop]
            if let value = dic[newValue] {
                contentDirection = value
            }
        }
    }
    
    public var contentDirection: ContentDirection = .topToBottom {
        didSet {
            updateButton()
        }
    }
    
    @IBInspectable public var imageScale: CGFloat = 1 {
        didSet {
            updateButton()
        }
    }
    
    @IBInspectable public var spacing: CGFloat = 10 {
        didSet {
            updateButton()
        }
    }
    
    var isInitTitleLabel: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.titleLabel?.textAlignment = .center
    }
    
    func updateButton() {
        setNeedsLayout()
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return myIntrinsicContentSize()
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            return myIntrinsicContentSize()
        }
    }
    
    public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let intrinsic = intrinsicContentRect(forContentRect: contentRect)
        let result = imageRect(forIntrinsicContentRect: intrinsic)
        return adjust(rect: result, insets: imageEdgeInsets)
    }

    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        defer {
            isInitTitleLabel = true
        }
        let intrinsic = intrinsicContentRect(forContentRect: contentRect)
        let result = titleRect(forIntrinsicContentRect: intrinsic)
        return adjust(rect: result, insets: titleEdgeInsets)
    }

}

extension CHButton {
    
    func intrinsicContentRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = CGRect.zero
        rect.size = intrinsicContentSizeWithDirection()
        if rect.width > contentRect.width {
            rect.size.width = contentRect.width
        }
        if rect.height > contentRect.height {
            rect.size.height = contentRect.height
        }
        switch contentHorizontalAlignment {
        case .left, .leading:
            rect.origin.x = contentRect.minX
        case .right, .trailing:
            rect.origin.x = contentRect.maxX - rect.width
        case .center:
            rect.origin.x = contentRect.midX - rect.width / 2
        case .fill:
            rect.origin.x = contentRect.minX
            rect.size.width = contentRect.width
        @unknown default:
            ()
        }
        switch contentVerticalAlignment {
        case .top:
            rect.origin.y = contentRect.minY
        case .bottom:
            rect.origin.y = contentRect.maxY - rect.height
        case .center:
            rect.origin.y = contentRect.midY - rect.height / 2
        case .fill:
            rect.origin.y = contentRect.minY
            rect.size.height = contentRect.height
        @unknown default:
            ()
        }
        return rect
    }
    
    func imageRect(forIntrinsicContentRect contentRect: CGRect) -> CGRect {
        let imageSize = intrinsicImageViewSize()
        if imageSize == .zero {
            return CGRect.zero
        }
        let titleSize = intrinsicTitleLabelSize()
        if titleSize == .zero {
            return contentRect
        }
        var rect = CGRect.zero
        if contentDirection == .leftToRight || contentDirection == .rightToLeft {
            switch contentVerticalAlignment {
            case .fill:
                rect.origin.y = contentRect.minY
                rect.size.height = contentRect.height
            case .center:
                rect.size.height = min(imageSize.height, contentRect.height)
                rect.origin.y = contentRect.midY - rect.height / 2
            case .top:
                rect.origin.y = contentRect.minY
                rect.size.height = min(imageSize.height, contentRect.height)
            case .bottom:
                rect.size.height = min(imageSize.height, contentRect.height)
                rect.origin.y = contentRect.maxY - rect.height
            @unknown default:
                ()
            }
            if contentHorizontalAlignment == .fill {
                if (imageSize.width + titleSize.width + spacing) < contentRect.width {
                    let scale = imageSize.width / (imageSize.width + titleSize.width + spacing)
                    rect.size.width = contentRect.width * scale
                }else {
                    rect.size.width = min(imageSize.width, contentRect.width)
                }
            }else {
                rect.size.width = min(imageSize.width, contentRect.width)
            }
            if contentDirection == .leftToRight {
                rect.origin.x = contentRect.minX
            }else {
                rect.origin.x = contentRect.maxX - rect.width
            }
        }else {
            switch contentHorizontalAlignment {
            case .fill:
                rect.origin.x = contentRect.minX
                rect.size.width = contentRect.width
            case .center:
                rect.size.width = min(imageSize.width, contentRect.width)
                rect.origin.x = contentRect.midX - rect.width / 2
            case .left, .leading:
                rect.origin.x = contentRect.minX
                rect.size.width = min(imageSize.width, contentRect.width)
            case .right, .trailing:
                rect.size.width = min(imageSize.width, contentRect.width)
                rect.origin.x = contentRect.maxX - rect.width
            @unknown default:
                ()
            }
            if contentVerticalAlignment == .fill {
                if (imageSize.height + titleSize.height + spacing) < contentRect.height {
                    let scale = imageSize.height / (imageSize.height + titleSize.height + spacing)
                    rect.size.height = contentRect.height * scale
                }else {
                    rect.size.height = min(imageSize.height, contentRect.height)
                }
            }else {
                rect.size.height = min(imageSize.height, contentRect.height)
            }
            if contentDirection == .topToBottom {
                rect.origin.y = contentRect.minY
            }else {
                rect.origin.y = contentRect.maxY - rect.height
            }
        }
        return rect
    }
    
    func titleRect(forIntrinsicContentRect contentRect: CGRect) -> CGRect {
        let titleSize = intrinsicTitleLabelSize()
        if titleSize == .zero {
            return .zero
        }
        let imageSize = intrinsicImageViewSize()
        if imageSize == .zero {
            return contentRect
        }
        let imageRect = self.imageRect(forIntrinsicContentRect: contentRect)
        var rect = CGRect.zero
        if contentDirection == .leftToRight || contentDirection == .rightToLeft {
            switch contentVerticalAlignment {
            case .fill:
                rect.origin.y = contentRect.minY
                rect.size.height = contentRect.height
            case .center:
                rect.size.height = titleSize.height
                rect.origin.y = contentRect.midY - rect.height / 2
            case .top:
                rect.origin.y = contentRect.minY
                rect.size.height = titleSize.height
            case .bottom:
                rect.size.height = titleSize.height
                rect.origin.y = contentRect.maxY - rect.height
            @unknown default:
                ()
            }
            if contentHorizontalAlignment == .fill {
                if (imageSize.width + titleSize.width + spacing) < contentRect.width {
                    let scale = titleSize.width / (imageSize.width + titleSize.width + spacing)
                    rect.size.width = contentRect.width * scale
                }else {
                    let width = contentRect.width - min(imageSize.width, contentRect.width) - spacing
                    rect.size.width = max(0, width)
                }
            }else {
                let width = contentRect.width - imageRect.width - spacing
                rect.size.width = max(0, width)
            }
            if contentDirection == .leftToRight {
                rect.origin.x = contentRect.maxX - rect.width
            }else {
                rect.origin.x = contentRect.minX
            }
        }else {
            switch contentHorizontalAlignment {
            case .fill:
                rect.origin.x = contentRect.minX
                rect.size.width = contentRect.width
            case .center:
                rect.size.width = titleSize.width
                rect.origin.x = contentRect.midX - rect.width / 2
            case .left, .leading:
                rect.origin.x = contentRect.minX
                rect.size.width = titleSize.width
            case .right, .trailing:
                rect.size.width = titleSize.width
                rect.origin.x = contentRect.maxX - rect.size.width
            @unknown default:
                ()
            }
            if contentVerticalAlignment == .fill {
                if (titleSize.height + imageSize.height + spacing) < contentRect.height {
                    let scale = titleSize.height / (titleSize.height + imageSize.height + spacing)
                    rect.size.height = contentRect.height * scale
                }else {
                    rect.size.height = contentRect.height - min(imageSize.height, contentRect.height) - spacing
                }
            }else {
                rect.size.height = titleSize.height
            }
            if contentDirection == .topToBottom {
                if contentVerticalAlignment == .fill {
                    rect.origin.y = contentRect.maxY - rect.height
                }else {
                    rect.origin.y = imageRect.maxY + spacing
                }
            }else {
                rect.origin.y = contentRect.minY
            }
        }
        return rect
    }
    
    func adjust(rect: CGRect, insets: UIEdgeInsets) -> CGRect {
        var result = CGRect.zero
        result.origin.x = rect.minX + insets.left
        let width = rect.width - insets.left - insets.right
        if width >= 0 {
            result.size.width = width
        }else {
            result.size.width = -width
            result.origin.x = result.origin.x + width
        }
        result.origin.y = rect.minY + insets.top
        let height = rect.height - insets.top - insets.bottom
        if height >= 0 {
            result.size.height = height
        }else {
            result.size.height = -height
            result.origin.y = result.origin.y + height
        }
        return result
    }
    
}


extension CHButton {
    
    func myIntrinsicContentSize() -> CGSize {
        var size = intrinsicContentSizeWithDirection()
        size.width = size.width + contentEdgeInsets.left + contentEdgeInsets.right
        size.height = size.height + contentEdgeInsets.top + contentEdgeInsets.bottom
        if size.width == 0 {
            size.width = 10
        }
        if size.height == 0 {
            size.height = 10
        }
        return size
    }
    
    func intrinsicContentSizeWithDirection() -> CGSize {
        let imageSize = intrinsicImageViewSize()
        let titleLabelSize = intrinsicTitleLabelSize()
        let spacing: CGFloat
        if imageSize != .zero, titleLabelSize != .zero {
            spacing = self.spacing
        }else {
            spacing = 0
        }
        var result: CGSize = .zero
        switch contentDirection {
        case .leftToRight, .rightToLeft:
            result.width = imageSize.width + titleLabelSize.width + spacing
            result.height = max(imageSize.height, titleLabelSize.height)
        case .topToBottom, .bottomToTop:
            result.width = max(imageSize.width, titleLabelSize.width)
            result.height = imageSize.height + titleLabelSize.height + spacing
        }
        return result
    }
    
    func intrinsicImageViewSize() -> CGSize {
        guard let image = currentImage else {
            return .zero
        }
        var size = image.size
        size.width = size.width * imageScale
        size.height = size.height * imageScale
        return size
    }

    func tempTitleLabel() -> UILabel {
        if isInitTitleLabel, let label = titleLabel {
            let data = NSKeyedArchiver.archivedData(withRootObject: label)
            if let label = NSKeyedUnarchiver.unarchiveObject(with: data) as? UILabel {
                return label
            }
        }
        let label = UILabel()
        if let font = self.value(forKey: "lazyTitleViewFont") as? UIFont {
            label.font = font
        }
        if let title = currentTitle {
            label.text = title
        }
        if let attributedTitle = currentAttributedTitle {
            label.attributedText = attributedTitle
        }
        return label
    }
    
    func intrinsicTitleLabelSize() -> CGSize {
        let label = tempTitleLabel()
        return label.intrinsicContentSize
    }
    
}