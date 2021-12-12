//
//  URLRequest+extension.swift
//  pokeapi
//
//  Created by Simon Deutsch on 11.12.21.
//

import Foundation

enum httpMethodEnum: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

extension URLRequest {
    mutating func setHttpMethod(_ method: httpMethodEnum) {
        httpMethod = method.rawValue
    }
}
