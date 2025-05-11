//
//  Url.swift
//  test_jwt
//
//  Created by Uidai MAC -2024 -2 on 27/03/25.
//

import Foundation

extension URL {
    var queryParameters: [String: String] {
        var parameters = [String: String]()
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems {
            for item in queryItems {
                parameters[item.name] = item.value
            }
        }
        return parameters
    }
}
