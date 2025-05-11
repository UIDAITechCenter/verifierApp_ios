
import UIKit

extension UIFont {
    // MARK: Manrope
    enum ManropeWeight: String, CaseIterable {
        case Bold = "Bold"
        case ExtraBold = "ExtraBold"
        case ExtraLight = "ExtraLight"
        case Light = "Light"
        case Medium = "Medium"
        case Regular = "Regular"
        case SemiBold = "SemiBold"
        
        public init?(weight: String) {
            guard let matchedWeight = ManropeWeight.allCases.filter({ $0.rawValue.lowercased() == weight.lowercased() }).first else {
                return nil
            }
            self = matchedWeight
        }
    }
    
    static func Manrope(size: CGFloat, weight: ManropeWeight) -> UIFont {
        let fontName = "Manrope-\(weight.rawValue)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    enum RobotoMonoWeight: String, CaseIterable {
        case Bold = "Bold"
        case Medium = "Medium"
        case Regular = "Regular"
        
        public init?(weight: String) {
            guard let matchedWeight = RobotoMonoWeight.allCases.filter({ $0.rawValue.lowercased() == weight.lowercased() }).first else {
                return nil
            }
            self = matchedWeight
        }
    }
    
    static func RobotoMono(size: CGFloat, weight: RobotoMonoWeight) -> UIFont {
        let fontName = "RobotoMono-\(weight.rawValue)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    enum RobotoSerifWeight: String, CaseIterable {
        case SemiBold = "SemiBold"
        case Medium = "Medium"
        case Regular = "Regular"
        
        public init?(weight: String) {
            guard let matchedWeight = RobotoSerifWeight.allCases.filter({ $0.rawValue.lowercased() == weight.lowercased() }).first else {
                return nil
            }
            self = matchedWeight
        }
    }
    
    static func RobotoSerif(size: CGFloat, weight: RobotoSerifWeight) -> UIFont {
        let fontName = "RobotoSerif-\(weight.rawValue)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

