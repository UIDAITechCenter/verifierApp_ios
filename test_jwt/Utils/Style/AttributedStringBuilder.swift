//
//  AttributedStringBuilder.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import UIKit

private enum KnownNodes: String, CaseIterable {
    case icon, number, text, link, format, strike

    static var leafNodes: [KnownNodes] = [.icon, .number, .link]

    var knownAttributesKeys: [String: NSAttributedString.Key] {
        switch self {
            case .format, .text:
                return knownAttributesKeysForText
            case .link:
                var keys = knownAttributesKeysForText
                keys["url"] = .link
                return keys
            case .strike:
                var keys = knownAttributesKeysForText
                keys["strike"] = .strikethroughStyle
                return keys

            case .icon, .number:
                return [:]
        }
    }

    private var knownAttributesKeysForText: [String: NSAttributedString.Key] {
        [
            "font": .font,
            "fgClr": .foregroundColor,
            "bgClr": .backgroundColor,
            "strike": .strikethroughStyle,
            "underline": .underlineStyle
        ]
    }
}

private struct Attribute {

    static let supportedFonts: [any AttributedFont.Type] = {
        [
            UIFont.ManropeWeight.self,
            UIFont.RobotoMonoWeight.self
        ]
    }()

    let key: NSAttributedString.Key
    let value: Any

    static func getStringAttributesFrom(customAttribute dict: [String: String], for node: KnownNodes, fontSize: CGFloat) -> [Attribute] {

        let knownAttributesKeys: [String: NSAttributedString.Key] = node.knownAttributesKeys
        var attributes: [Attribute] = []
        for attribute in dict where knownAttributesKeys[attribute.key] != nil {
            let key = knownAttributesKeys[attribute.key]!
            if attribute.key == "font" {
                // font must be added to `supportedFonts` in order to support it
                // example: denton_lightitalic
                let fontAttributes = attribute.value.split(separator: "_")
                if fontAttributes.count == 2 {
                    let fontName = fontAttributes[0].lowercased()
                    let fontWeight = String(fontAttributes[1])
                    if let attributedFont = supportedFonts.first(where: { $0.attributedPrefix.lowercased() == fontName }),
                       let font = attributedFont.getFont(weight: fontWeight, size: fontSize)
                    {
                        attributes.append(Attribute(key: key, value: font))
                    }
                } else if let weight = UIFont.ManropeWeight(weight: attribute.value) {
                    attributes.append(Attribute(key: key, value: UIFont.Manrope(size: fontSize, weight: weight)))
                }
            } else if attribute.key == "url" {
                attributes.append(Attribute(key: key, value: attribute.value))
            } else if attribute.key == "strike" {
                attributes.append(Attribute(key: key, value: NSUnderlineStyle.single.rawValue))
            } else if attribute.key == "underline" {
                attributes.append(Attribute(key: NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue))
            } else {
                if !attribute.value.isEmpty {
                    attributes.append(Attribute(key: key, value: UIColor.fromHex(attribute.value)))
                }
            }
        }
        return attributes
    }
}

private struct AttributeStack {
    private var stack: [Attribute] = []
    private let baseAttributeDict: [NSAttributedString.Key: Any]

    init(baseStringAttributes: [NSAttributedString.Key: Any] = [:]) {
        self.baseAttributeDict = baseStringAttributes
    }

    mutating func push(attribute: Attribute) {
        stack.append(attribute)
    }

    mutating func push(attributes: [Attribute]) {
        stack.append(contentsOf: attributes)
    }

    mutating func pop() -> Attribute? {
        return stack.popLast()
    }

    mutating func popLast(_ k: Int) {
        stack.removeLast(k)
    }

    func getAttributes() -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = baseAttributeDict
        for attribute in stack {
            attributes[attribute.key] = attribute.value
        }
        return attributes
    }

    mutating func clear() {
        stack.removeAll()
    }
}

private struct LeafNodeProcessor {
    static func getFormattedText(fromNode node: KnownNodes, attributes: [String: String], content: String, baseFontSize fontSize: CGFloat, isLinkSupported: Bool) -> (string: String, attributes: [Attribute]) {
        switch node {
            case .icon:
                return getGlyphStringT(forIcon: content, using: attributes, baseFontSize: fontSize)//(string: getGlyphString(forIcon: content), [])
            case .number:
                return getFormatted(numberString: content, using: attributes)
            case .link:
                return getFormattedLink(fromNode: node, attributes: attributes, content: content, baseFontSize: fontSize, isLinkSupported: isLinkSupported)
            default:
                return (string: content, [])
        }
    }

    static func getFormattedLink(fromNode node: KnownNodes, attributes: [String: String], content: String, baseFontSize fontSize: CGFloat, isLinkSupported: Bool) -> (string: String, attributes: [Attribute]) {
        var updatedContent = content
        var customAttributes = attributes
        if !isLinkSupported, let linkUrl = attributes["url"], !linkUrl.isEmpty {
            customAttributes.removeValue(forKey: "url")
            updatedContent = [content, linkUrl].joined(separator: " ")
        }
        let processedAttributes: [Attribute] = Attribute.getStringAttributesFrom(customAttribute: customAttributes, for: node, fontSize: fontSize)
        return (string: updatedContent, processedAttributes)
    }

    static private func getFormatted(numberString string: String, using attributes: [String: String]) -> (string: String, attributes: [Attribute]) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        if let localeString = attributes["locale"] {
            formatter.locale = Locale(identifier: localeString)
            formatter.usesGroupingSeparator = true
        }
        if attributes["float"] == "true" {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
        } else {
            formatter.maximumFractionDigits = 0
        }
        guard let number = formatter.number(from: string), let numString = formatter.string(from: number) else {
            return (string: string, attributes: [])
        }
        // build attributes for formatted string
        return (string: numString, attributes: [])

    }

    static private func getGlyphStringT(forIcon name: String, using attributes: [String: String], baseFontSize fontSize: CGFloat) -> (string: String, attributes: [Attribute]) {
        switch name {
        case "INR":
            return (string: "₹", attributes: [])
        case "CRED_GEM":
            return (string: "\u{e901}", attributes: [Attribute(key: .font, value: UIFont(name: "Cred-Symbols", size: fontSize) as Any)])
        case "CRED_COIN":
            return (string: "\u{e900}", attributes: [Attribute(key: .font, value: UIFont(name: "Cred-Symbols", size: fontSize) as Any)])
        case "GAIN":
            return (string: "\u{e800}", attributes: [Attribute(key: .font, value: UIFont(name: "fontello", size: fontSize) as Any), Attribute(key: .foregroundColor, value: UIColor.CustomColors.forest)])
        case "LOSS":
            return (string: "\u{e801}", attributes: [Attribute(key: .font, value: UIFont(name: "fontello", size: fontSize) as Any), Attribute(key: .foregroundColor, value: UIColor.CustomColors.coral)])
        default:
            return (string: name, attributes: [])
        }
    }
}

public class AttributedStringBuilder {
    let document: Document?
    private var attributeStack: AttributeStack
    private var orignalContent: String? = nil
    private var cachedResult: NSAttributedString? = nil
    private var baseAttributes: [NSAttributedString.Key: Any] = AttributedStringStyle.getAttributesForLineBreakMode()
    private var fontSize: CGFloat = 16
    private var xmlStr: String? = nil

    convenience init(xmlString: String, baseStyle style: AttributedStringStyle?, additionalAttributes: [NSAttributedString.Key: Any]? = nil) {
        let doc = try? Document(string: xmlString)
        self.init(document: doc, baseStyle: style, additionalAttributes: additionalAttributes)
        self.xmlStr = xmlString
    }

    init(document: Document?, baseStyle: AttributedStringStyle?, additionalAttributes: [NSAttributedString.Key: Any]? = nil) {
        self.document = document
        if let baseStyle = baseStyle {
            baseAttributes = baseStyle.attributes()
            if let attributes = additionalAttributes {
                baseAttributes = baseAttributes.merging(attributes) { (_, new) in new }
            }
            //TODO: Fix line truncation, doing truncatingTailOnNil is not honouring the lineheight
            //baseAttributes = baseStyle.attributes().merging(additionalAttributes.truncatingTailOnNil) { (_, new) in new }
        }
        attributeStack = AttributeStack(baseStringAttributes: baseAttributes)
        fontSize = (baseAttributes[.font] as? UIFont)?.pointSize ?? fontSize
    }

    public func getAttributedString(isLinkSupported: Bool = false) -> NSAttributedString {
        guard let doc = document, doc.rootElement.name == "format" else {
            return NSAttributedString(string: xmlStr ?? .empty(), attributes: baseAttributes)
        }
        if cachedResult != nil {
            return cachedResult!
        }
        cachedResult = getAttributedString(withRoot: doc.rootElement, isLinkSupported: isLinkSupported)
        attributeStack.clear()
        baseAttributes.removeAll()
        return cachedResult!
    }

    private func getAttributedString(withRoot root: Element, isLinkSupported: Bool) -> NSAttributedString {
        guard let rootString = root.content else {
            return NSAttributedString(string: .empty(), attributes: attributeStack.getAttributes())
        }
        let rootNode = KnownNodes(rawValue: root.name.emptyOnNil)
        let isLeafNode = rootNode != nil && KnownNodes.leafNodes.contains(rootNode!)
        let nodeResult = NSMutableAttributedString(string: .empty())
        if isLeafNode {
            let processedInfo = LeafNodeProcessor.getFormattedText(fromNode: rootNode!, attributes: root.attributes, content: root.content ?? .empty(), baseFontSize: fontSize, isLinkSupported: isLinkSupported)
            attributeStack.push(attributes: processedInfo.attributes)
            let nodeResult = NSAttributedString(string: processedInfo.string, attributes: attributeStack.getAttributes())
            attributeStack.popLast(processedInfo.attributes.count)
            return nodeResult
        } else {
            let attributes: [Attribute]
            if let rootNodeT = rootNode {
                attributes = Attribute.getStringAttributesFrom(customAttribute: root.attributes, for: rootNodeT, fontSize: fontSize)
            } else {
                attributes = []
            }
            attributeStack.push(attributes: attributes)
            var fromIndex: String.Index = rootString.startIndex
            for child in root.children() where child.content?.isEmpty == false {
                guard let range = rootString.range(of: child.content!, range: fromIndex ..< rootString.endIndex) else {
                    continue
                }
                let stringToProcess = rootString[fromIndex ..< range.lowerBound]
                if !stringToProcess.isEmpty {
                    nodeResult.append(NSAttributedString(string: String(stringToProcess), attributes: attributeStack.getAttributes()))
                }
                fromIndex = range.upperBound
                nodeResult.append(getAttributedString(withRoot: child, isLinkSupported: isLinkSupported))
            }
            if fromIndex < rootString.endIndex {
                let stringToProcess = rootString[fromIndex ..< rootString.endIndex]
                // process string if not empty
                nodeResult.append(NSAttributedString(string: String(stringToProcess), attributes: attributeStack.getAttributes()))
                fromIndex = rootString.endIndex
            }
            attributeStack.popLast(attributes.count)
            return nodeResult
        }
    }
}
