
import Foundation

public extension String {

    @inline(__always) static func empty() -> String {
        return ""
    }

    @inline(__always) static func rupeeSymbol() -> String {
        return "\u{20B9}"
    }

    @inline(__always) static func notAvailable() -> String {
        return "N/A"
    }

    @inline(__always) static func lineBreak() -> String {
        return "\n"
    }

    @inline(__always) static func escapedLineBreak() -> String {
        return "\\n"
    }

    var isNotEmpty: Bool {
        return !self.isEmpty
    }

    func match(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: utf16.count)
            let match = regex.firstMatch(in: self, options: [], range: range)
            return match != nil
        } catch {
            return false
        }
    }
}

public extension String {

    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }

    func replaceBracket_s_stringBasedOnCount(count: Int) -> String {
        var titleText = self
        if count == 1 {
            titleText = titleText.replacingOccurrences(of: "(s)", with: "")
        } else {
            titleText = titleText.replacingOccurrences(of: "(s)", with: "s")
        }
        return titleText
    }
}

public extension String {
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
}

public extension String {
    @inline(__always) func isColorHex() -> Bool {
        var copy = self
        if self.first == "#" {
            copy.remove(at: copy.startIndex)
        }
        guard [8, 6].contains(copy.count) else {
            return false
        }
        return copy.isValidHexNumber()
    }

    @inline(__always) func isValidHexNumber() -> Bool {
        let chars = CharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard self.uppercased().rangeOfCharacter(from: chars) == nil else {
            return false
        }
        return true
    }
}

public extension Optional where Wrapped: StringProtocol {

    @inline(__always) var emptyOnNil: String {
        return self as? String ?? .empty()
    }

    @inline(__always) var notAvailableOnNil: String {
        return self as? String ?? .notAvailable()
    }

    @inline(__always) var isNullOrEmpty: Bool {
        return (self as? String ?? .empty()) == .empty()
    }

    @inline(__always) var isNotNilAndNonEmpty: Bool {
        guard let self = self else {
            return false
        }
        return !self.isEmpty
    }

    @inline(__always) var isEmptyOrNil: Bool {
        guard let self = self else {
            return true
        }
        return self.isEmpty
    }
}

public extension String {
    var isValidURL: Bool {
        return !self.isEmpty && URL(string: self) != nil
    }

    // swiftlint:disable url_init
    func getURL() -> URL? {
        // this will help us support both xcode 14/15 at the same time
        #if swift(<5.9)
        return URL(string: self)
        #else
        if #available(iOS 17, *) {
            return URL(string: self, encodingInvalidCharacters: false)
        } else {
            return URL(string: self)
        }
        #endif
    }
}

public extension String {
    @inline(__always) func boolValue() -> Bool? {
        switch self.lowercased() {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }
}

public extension String {
    mutating func insertFromEnd(character char: Character, atIntervalsOf offset: Int) {
        guard offset > 0, self.count/offset > 0 else { return }
        let itterations: Int = self.count/offset
        var indexes = [String.Index?]()
        for i in 1...itterations {
            indexes.append(self.index(self.endIndex, offsetBy: -(i*offset), limitedBy: self.startIndex))
        }
        indexes.forEach{
            self.insert(char, at: $0 ?? self.startIndex)
        }
    }

    mutating func insertFromBeginnig(character char: Character, atIntervalsOf offset: Int) {
        guard offset > 0, self.count/offset > 0 else { return }
        let itterations: Int = self.count/offset
        var indexes = [String.Index?]()
        for i in 1...itterations {
            indexes.append(self.index(self.startIndex, offsetBy: (i*offset), limitedBy: self.endIndex))
        }
        indexes.reversed().forEach{
            self.insert(char, at: $0 ?? self.endIndex)
        }
    }

    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }

    func getStringWithCommaFormatting(_ groupingSize: Int = 3, _ secondaryGroupingSize: Int = 2) -> String {

        // "000123400".getStringWithCommaFormatting(3, 2) -> "00,01,23,400"

        guard self.count > groupingSize && groupingSize > 0 && secondaryGroupingSize > 0 else { return self }

        var reversedStr = String(self.reversed())
        var result: [String] = [String(reversedStr.prefix(groupingSize))]

        reversedStr = String(reversedStr.dropFirst(groupingSize))
        result.append(contentsOf: reversedStr.components(withMaxLength: secondaryGroupingSize))

        return String(result.joined(separator: ",").reversed())
    }
}
extension UnsafePointer {
  func toString() -> String? {
    return String(validatingUTF8: UnsafeRawPointer(self).assumingMemoryBound(to: Int8.self))
  }
}

extension UnsafeMutablePointer {
  func toString() -> String? {
    return String(validatingUTF8: UnsafeRawPointer(self).assumingMemoryBound(to: Int8.self))
  }
}
extension String {
    func attributed(by style: AttributedStringStyle?, additionalAttributes: [NSAttributedString.Key: Any]? = nil, isLinkSupported: Bool = false) -> NSAttributedString {
        return AttributedStringBuilder(xmlString: self, baseStyle: style, additionalAttributes: additionalAttributes).getAttributedString(isLinkSupported: isLinkSupported)
    }
}
