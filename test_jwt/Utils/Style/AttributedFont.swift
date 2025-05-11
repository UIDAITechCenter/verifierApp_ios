//
//  AttributedFont.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import UIKit.UIFont

protocol AttributedFont {
    static var attributedPrefix: String { get }

    static func getFont(weight: String, size: CGFloat) -> UIFont?
}

// MARK: - ManropeWeight
extension UIFont.ManropeWeight: AttributedFont {
    static var attributedPrefix: String {
        "manrope"
    }

    static func getFont(weight: String, size: CGFloat) -> UIFont? {
        guard let weight = UIFont.ManropeWeight(weight: weight) else { return nil }
        return UIFont.Manrope(size: size, weight: weight)
    }
}

// Mark: - RobotoMono
extension UIFont.RobotoMonoWeight: AttributedFont {
    static var attributedPrefix: String {
        "robotomono"
    }

    static func getFont(weight: String, size: CGFloat) -> UIFont? {
        guard let weight = UIFont.RobotoMonoWeight(weight: weight) else { return nil }
        return UIFont.RobotoMono(size: size, weight: weight)
    }
}
