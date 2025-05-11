//
//  UIColors.swift
//  test_jwt
//
//  Created by Uidai MAC -2024 -2 on 26/03/25.
//

import UIKit

extension UIColor {
    struct CustomColors {
        static let shadow = UIColor(fromHex: "#0000001A") // Black with 10% opacity
        static let sandstone = UIColor(fromHex: "#BDA886")
        static let forest = UIColor(fromHex: "#4a9923")
        static let coral = UIColor(fromHex: "#dd5c64")
        static let sand = UIColor(fromHex: "#D5BE8E")
        static let parchment = UIColor(fromHex: "#D5D0C2")
        static let midnight = UIColor(fromHex: "#0D0D0D")
        static let oatmeal = UIColor(fromHex: "#D5CDB6")
        static let espresso = UIColor(fromHex: "#4D3611")
        static let toffee = UIColor(fromHex: "#875E37")
        static let amber = UIColor(fromHex: "#A26127")
        static let hazelnut = UIColor(fromHex: "#A07852")
        static let eggshell = UIColor(fromHex: "#EEE4D6")
        static let slate = UIColor(fromHex: "#878178")
        static let wheat = UIColor(fromHex: "#CEB682")
        static let walnut = UIColor(fromHex: "#594B3F")
        static let bronze = UIColor(fromHex: "#745C32")
        static let darkCyan = UIColor(fromHex: "#004F74")
        static let bakerChocolate = UIColor(fromHex: "#4D3611")
        static let verifytext = UIColor(fromHex: "#0D0D0D")
        static let darkNight = UIColor(fromHex: "#144CC7")
        static let homeBgGradientColors = [UIColor(fromHex: "ffffff").cgColor, UIColor(fromHex: "0684bf").cgColor]
        static let homeBgGradient2 = [UIColor(fromHex: "ffffff").cgColor, UIColor(fromHex: "32b1ed").cgColor]
    }
    
    @inline(__always) convenience init(fromHex hex: String, alpha opacity: CGFloat? = nil) {
        // following ARGB color hex. same as android
        let colorCode = hex.suffix(6)
        let hexint = Int(UInt32(fromHex: String(colorCode)))
        let red: CGFloat = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue: CGFloat = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha: CGFloat
        if hex.count >= 8 {
            let alphaCode = hex.suffix(8).prefix(2)
            let alphaHexInt = Int(UInt32(fromHex: String(alphaCode)))
            alpha = opacity ?? CGFloat(alphaHexInt & 0xff) / 255.0
        } else {
            alpha = opacity ?? 1.0
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

enum ColorAlpha: CGFloat {
    case FF = 1.00
    case F2 = 0.95
    case E6 = 0.90
    case D9 = 0.85
    case CC = 0.80
    case BF = 0.75
    case B3 = 0.70
    case A6 = 0.65
    case a99 = 0.60
    case a8C = 0.55
    case a80 = 0.50
    case a73 = 0.45
    case a66 = 0.40
    case a59 = 0.35
    case a4D = 0.30
    case a40 = 0.25
    case a33 = 0.20
    case a26 = 0.15
    case a1A = 0.10
    case a0D = 0.05
    case a00 = 0.00
}

public extension UInt32 {
    init(fromHex hex: String) {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hex)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        self = hexInt
    }
}

public extension UIColor {
    @inline(__always) static func fromHex(_ hex: String, alpha opacity: CGFloat? = nil) -> UIColor {
        // following ARGB color hex. same as android
        let colorCode = hex.suffix(6)
        let hexint = Int(intFromHexString(hexStr: String(colorCode)))
        let red: CGFloat = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue: CGFloat = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha: CGFloat
        if hex.count >= 8 {
            let alphaCode = hex.suffix(8).prefix(2)
            let alphaHexInt = Int(intFromHexString(hexStr: String(alphaCode)))
            alpha = opacity ?? CGFloat(alphaHexInt & 0xff) / 255.0
        } else {
            alpha = opacity ?? 1.0
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }

    static func fromHex(_ hexString: String?, alpha: CGFloat? = nil, default: UIColor) -> UIColor {
        if let color = hexString {
            return UIColor(fromHex: color, alpha: alpha)
        } else {
            return `default`
        }
    }
}
