//
//  APIError.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum APIError: Error {
  case invalidURL
  case invalidResponse
  case invalidStatusCode
  case invalidData
}

extension APIError: LocalizedError {
  
  var errorDescription: String? {
    
    switch self {
    case .invalidURL:
      return NSLocalizedString("Invalid URL", comment: "")
      
    case .invalidResponse:
      return NSLocalizedString("Invalid Response", comment: "")
      
    case .invalidStatusCode:
      return NSLocalizedString("Invalid status code", comment: "")
      
    case .invalidData:
      return NSLocalizedString("Invalid data", comment: "")
    }
  }
}
