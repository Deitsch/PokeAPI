//
//  PokeAPIError.swift
//  
//
//  Created by Simon Deutsch on 11.12.21.
//

import Foundation

public enum PokeAPIError: Error {
    case internalServerError
    case someError
    case decodingError(DecodingError)
    case unknown
}
