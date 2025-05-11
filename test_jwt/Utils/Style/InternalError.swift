//
//  InternalError.swift
//  Pehchan
//
//  Created by farees.syed on 07/03/25.
//

import Foundation
import libxml2

enum InternalError: Error {

  case unknown
  case parse(message: String, code: Int)

  static func lastError() -> InternalError {
    guard let pointer = xmlGetLastError()
    else {
      return .unknown
    }

    let message = pointer.pointee.message.toString() ?? .empty()
    let code = Int(pointer.pointee.code)

    return .parse(message: message, code: code)
  }
}
