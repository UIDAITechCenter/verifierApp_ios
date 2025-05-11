//
//  Document.swift
//  Pehchan
//
//  Created by farees.syed on 06/03/25.
//

import Foundation
import libxml2

open class Document {

  public enum DocumentKind {
    case xml, html
  }

  let cDocument: xmlDocPtr

  public let rootElement: Element

  // MARK: - Initialization

  public convenience init(string: String, encoding: String.Encoding = .utf8, kind: DocumentKind = .xml) throws {
    guard let data = string.data(using: encoding)
    else {
      throw InternalError.unknown
    }

    try self.init(data: data, kind: kind)
  }

  public convenience init(data: Data, kind: DocumentKind = .xml) throws {
    let bytes = data.withUnsafeBytes {
      [Int8](UnsafeBufferPointer(start: $0, count: data.count))
    }

    try self.init(bytes: bytes)
  }

  public convenience init(nsData: NSData, kind: DocumentKind = .xml) throws {
    var bytes = [UInt8](repeatElement(0, count: nsData.length))
    nsData.getBytes(&bytes, length: bytes.count * MemoryLayout<UInt8>.size)
    let data = Data(bytes: bytes)

    try self.init(data: data)
  }

  public convenience init(bytes: [Int8], kind: DocumentKind = .xml) throws {
    let options: Int32

    switch kind {
    case .xml:
      options = Int32(XML_PARSE_NOWARNING.rawValue | XML_PARSE_NOERROR.rawValue | XML_PARSE_RECOVER.rawValue)
    case .html:
      options = Int32(HTML_PARSE_NOWARNING.rawValue | HTML_PARSE_NOERROR.rawValue | HTML_PARSE_RECOVER.rawValue)
    }

    guard let document = xmlReadMemory(bytes, Int32(bytes.count), "", nil, options)
    else {
      throw InternalError.lastError()
    }
    try self.init(document: document)
  }

  init(document: xmlDocPtr) throws {
    self.cDocument = document
    if let rootElementFromDoc = xmlDocGetRootElement(document) {
        self.rootElement = Element(node: rootElementFromDoc)
    } else {
        xmlFreeDoc(cDocument)
        throw InternalError.parse(message: "Not able to get root element", code: 10001)
    }
  }

  deinit {
    xmlFreeDoc(cDocument)
  }

  // MARK: - Info

  open var version: String? {
    return cDocument.pointee.version.toString()
  }

  open var encoding: String? {
    return cDocument.pointee.encoding.toString()
  }

  public var hasNamespace: Bool {
    return rootElement.ns != nil
  }
}
