//
//  HttpError.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import Foundation

enum HttpError: Error {
    case invalidURL
    case requestFailed
    case failedParsing
    
    var description: String {
          switch self {
          case .invalidURL:
              "The provided URL is not valid"
          case .requestFailed:
              "The request failed"
          case .failedParsing:
              "The data could not be parsed"
          }
      }
}
