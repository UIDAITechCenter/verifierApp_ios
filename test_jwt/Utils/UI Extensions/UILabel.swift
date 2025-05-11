//
//  UILabel.swift
//  test_jwt
//
//  Created by Uidai MAC -2024 -2 on 26/03/25.
//

import UIKit

public extension UILabel {
    func hideOrSetNonEmpty(attributedText aText: NSAttributedString?, truncateTail: Bool = true, alignment: NSTextAlignment? = nil) {
        self.attributedText = aText
        self.isHidden = aText == nil || aText?.string.isEmpty == true
        if truncateTail {
            self.lineBreakMode = .byTruncatingTail
        }
        if let newAlignment = alignment {
            self.textAlignment = newAlignment
        }
    }
}
