//
//  Element+Query.swift
//  Pehchan
//
//  Created by farees.syed on 07/03/25.
//

import Foundation
import libxml2

public extension Element {

    func children(predicate: ((Element, Int) -> Bool)? = nil) -> [Element] {
    var elements = [Element]()
    var cursor = self.cNode.pointee.children
    var index = 0

    while cursor != nil {
      if cursor!.pointee.type == XML_ELEMENT_NODE {
        let element = Element(node: cursor!)
        if let predicate = predicate {
          if predicate(element, index) {
            elements.append(element)
          }
        } else {
          elements.append(element)
        }

        index += 1
      }

      cursor = cursor?.pointee.next
    }

    return elements
  }

    func children(name: String) -> [Element] {
    return children { element, index in
      return element.name == name
    }
  }

    func children(indexes: [Int]) -> [Element] {
    return children { element, index in
      return indexes.contains(index)
    }
  }

    func child(index: Int) -> Element? {
    return children(indexes: [index]).first
  }

    func firstChild(name: String) -> Element? {
    return children(name: name).first
  }
}
