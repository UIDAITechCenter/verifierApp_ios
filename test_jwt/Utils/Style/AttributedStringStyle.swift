//
//  AttributedStringStyle.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import UIKit

enum AttributedStringStyle {
    // MARK: Manrope
    case manropeMedium12(color: UIColor?)
    case manropeCapsMedium12(color: UIColor?)
    case manropeSemibold20(color: UIColor?)
    case manropeBold18(color: UIColor?)
    case manropeBold20(color: UIColor?)
    case manropeSemibold18(color: UIColor?)
    case manropeBold16(color: UIColor?)
    case manropeBold14(color: UIColor?)
    case manropeBold15(color: UIColor?)
    case manropeBold42(color: UIColor?)
    case manropeCapsMedium12Spaced(color: UIColor?)
    case manropeSemibold15(color: UIColor?)
    case manropeBold12(color: UIColor?)
    case manropeMedium12NoSpacing(color: UIColor?)
    case manropeCapsBold10(color: UIColor?)
    case manropeCapsExtraBold12(color: UIColor?)
    case manropeRegular12(color: UIColor?)
    case manropeRegular22(color: UIColor?)
    case manropeRegular28(color: UIColor?)
    case manropeRegular42(color: UIColor?)
    case manropeBold13(color: UIColor?)
    case manropeBold13Short(color: UIColor?)
    case manropeMedium12Tall(color: UIColor?)
    case manropeSemibold13(color: UIColor?)
    case manropeMedium11(color: UIColor?)
    case manropeRegular12Wide(color: UIColor?)
    case manropeBold14Wide(color: UIColor?)
    case manropeBold14Tight(color: UIColor?)
    case manropeBold22(color: UIColor?)
    case manropeBold28(color: UIColor?)
    case manropeMedium11Spaced(color: UIColor?)
    case manropeSemibold12(color: UIColor?)
    case manropeCapsBold10Tall(color: UIColor?)
    case manropeCapsBold22(color: UIColor?)
    case manropeSemibold40(color: UIColor?)
    case manropeMedium11Tall(color: UIColor?)
    
    // MARK: RobotoMono
    case robotoMonoRegular6(color: UIColor?)
    case robotoMonoCapsRegular11(color: UIColor?)
    case robotoMonoCapsRegular15(color: UIColor?)
    case robotoMonoCapsBold15(color: UIColor?)
    
    
    // MARK: RobotoSerif
    case robotoSerifMedium26(color: UIColor?)
    
    public static func getAttributesForLineBreakMode(_ mode: NSLineBreakMode = .byTruncatingTail) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = mode
        return [.paragraphStyle: paragraphStyle]
    }
    
    func attributes(fontSizeScale: CGFloat = 1.0) -> [NSAttributedString.Key: Any] {
        switch self {
        case .manropeMedium12(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.3)
        case .manropeCapsMedium12(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.3)
        case .manropeSemibold20(let fontColor):
            return buildAttributes(fontSize: 20.0, fontWeight: .SemiBold, fontColor: fontColor ?? .black, minLineHeight: nil, letterSpacing: 0.0)
        case .manropeBold18(let fontColor):
            return buildAttributes(fontSize: 18.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 25.2, letterSpacing: 0.5)
        case .manropeBold20(let fontColor):
            return buildAttributes(fontSize: 20.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 28, letterSpacing: 0.1)
        case .manropeSemibold18(let fontColor):
            return buildAttributes(fontSize: 18.0, fontWeight: .SemiBold, fontColor: fontColor ?? .black, minLineHeight: 25.2, letterSpacing: 0.5)
        case .manropeBold16(let fontColor):
            return buildAttributes(fontSize: 15.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.0)
        case .manropeBold14(let fontColor):
            return buildAttributes(fontSize: 14.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.0)
        case .manropeBold15(let fontColor):
            return buildAttributes(fontSize: 15.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.0)
        case .manropeBold42(let fontColor):
            return buildAttributes(fontSize: 42.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 46.0, letterSpacing: 0.0)
        case .manropeCapsMedium12Spaced(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.5)
        case .manropeSemibold15(let fontColor):
            return buildAttributes(fontSize: 15.0, fontWeight: .SemiBold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.0)
        case .manropeBold12(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.0)
        case .manropeBold28(let fontColor):
            return buildAttributes(fontSize: 28.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.0)
        case .manropeMedium12NoSpacing(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.0)
        case .manropeCapsBold10(let fontColor):
            return buildAttributes(fontSize: 10.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 12.5, letterSpacing: 1.5)
        case .manropeCapsExtraBold12(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .ExtraBold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 2.0)
        case .manropeRegular12(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.5)
        case .manropeRegular22(let fontColor):
            return buildAttributes(fontSize: 22.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 24.2, letterSpacing: 3)
        case .manropeRegular28(let fontColor):
            return buildAttributes(fontSize: 28.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 28.0, letterSpacing: 0.0)
        case .manropeRegular42(let fontColor):
            return buildAttributes(fontSize: 42.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 46.0, letterSpacing: 0.0)
        case .manropeBold13(let fontColor):
            return buildAttributes(fontSize: 13.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.5)
        case .manropeBold13Short(let fontColor):
            return buildAttributes(fontSize: 13.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.5)
        case .manropeMedium12Tall(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 20.0, letterSpacing: 0.5)
        case .manropeSemibold13(let fontColor):
            return buildAttributes(fontSize: 13.0, fontWeight: .SemiBold, fontColor: fontColor ?? .black, minLineHeight: 16.0, letterSpacing: 0.4)
        case .manropeMedium11(let fontColor):
            return buildAttributes(fontSize: 11.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.4)
        case .manropeRegular12Wide(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 21.6, letterSpacing: 4.5)
        case .manropeBold14Wide(let fontColor):
            return buildAttributes(fontSize: 14.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 19.6, letterSpacing: 4.5)
        case .manropeBold14Tight(let fontColor):
            return buildAttributes(fontSize: 14.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 19.6, letterSpacing: 0.7)
        case .manropeBold22(let fontColor):
            return buildAttributes(fontSize: 22.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 24.2, letterSpacing: 3)
        case .manropeMedium11Spaced(let fontColor):
            return buildAttributes(fontSize: 11.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 17.0, letterSpacing: 0.7)
        case .manropeSemibold12(let fontColor):
            return buildAttributes(fontSize: 12.0, fontWeight: .SemiBold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.5)
        case .manropeCapsBold10Tall(let fontColor):
            return buildAttributes(fontSize: 10.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 18.0, letterSpacing: 0.5)
        case .manropeCapsBold22(let fontColor):
            return buildAttributes(fontSize: 22.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 24.2, letterSpacing: 30.0)
        case .manropeSemibold40(let fontColor):
            return buildAttributes(fontSize: 40.0, fontWeight: .SemiBold, fontColor: fontColor ?? .black, minLineHeight: 44.0, letterSpacing: 5.0)
        case .manropeMedium11Tall(let fontColor):
            return buildAttributes(fontSize: 11.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 19.0, letterSpacing: 2.0)
        case .robotoMonoRegular6(let fontColor):
            return buildAttributes(fontSize: 6.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 6.0, letterSpacing: 2.4)
        case .robotoMonoCapsRegular11(let fontColor):
            return buildRobotoMonoAttributes(fontSize: 11.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 17, letterSpacing: 1)
        case .robotoMonoCapsRegular15(let fontColor):
            return buildRobotoMonoAttributes(fontSize: 15.0, fontWeight: .Regular, fontColor: fontColor ?? .black, minLineHeight: 17, letterSpacing: 1)
        case .robotoMonoCapsBold15(let fontColor):
            return buildRobotoMonoAttributes(fontSize: 15.0, fontWeight: .Bold, fontColor: fontColor ?? .black, minLineHeight: 17, letterSpacing: 1)
        case .robotoSerifMedium26(let fontColor):
            return buildRobotoSerifAttributes(fontSize: 26.0, fontWeight: .Medium, fontColor: fontColor ?? .black, minLineHeight: 29.12, letterSpacing: 0)
        }
    }

    private func buildAttributes(fontSize: CGFloat, fontWeight: UIFont.ManropeWeight, fontColor: UIColor, fontScale: CGFloat = 1.0, minLineHeight: CGFloat?, letterSpacing: CGFloat) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let lineHeight = minLineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = round(lineHeight * fontScale)
            attributes[.paragraphStyle] = paragraphStyle
        }

        attributes[.kern] = round(letterSpacing * fontScale)
        attributes[.font] = UIFont.Manrope(size: round(fontSize * fontScale), weight: fontWeight)
        attributes[.foregroundColor] = fontColor
        return attributes
    }
    
    private func buildRobotoMonoAttributes(fontSize: CGFloat, fontWeight: UIFont.RobotoMonoWeight, fontColor: UIColor, fontScale: CGFloat = 1.0, minLineHeight: CGFloat?, letterSpacing: CGFloat) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let lineHeight = minLineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = round(lineHeight * fontScale)
            attributes[.paragraphStyle] = paragraphStyle
        }

        attributes[.kern] = round(letterSpacing * fontScale)
        attributes[.font] = UIFont.RobotoMono(size: round(fontSize * fontScale), weight: fontWeight)
        attributes[.foregroundColor] = fontColor
        return attributes
    }
    
    private func buildRobotoSerifAttributes(fontSize: CGFloat, fontWeight: UIFont.RobotoSerifWeight, fontColor: UIColor, fontScale: CGFloat = 1.0, minLineHeight: CGFloat?, letterSpacing: CGFloat) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let lineHeight = minLineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = round(lineHeight * fontScale)
            attributes[.paragraphStyle] = paragraphStyle
        }

        attributes[.kern] = round(letterSpacing * fontScale)
        attributes[.font] = UIFont.RobotoSerif(size: round(fontSize * fontScale), weight: fontWeight)
        attributes[.foregroundColor] = fontColor
        return attributes
    }
}
