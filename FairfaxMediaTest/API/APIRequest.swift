//
//  APIRequest.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol APIRequestProtocol {
  func dataTask(with url: URL,
                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: APIRequestProtocol {}

enum APIResult {
  case success(Data)
  case failure(Error)
}

final class APIRequest {
  
  let url: URL
  
  init(url: URL) {
    self.url = url
  }
  
  func fetch(using session: APIRequestProtocol = URLSession(configuration: .ephemeral),
             completionHandler: @escaping (APIResult) -> Void) {
    let task = session.dataTask(with: url) { data, response, error in
      
      DispatchQueue.main.async {
        if let error = error {
          completionHandler(.failure(error))
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          completionHandler(.failure(APIError.invalidResponse))
          return
        }
        
        if 200 != response.statusCode {
          completionHandler(.failure(APIError.invalidStatusCode))
          return
        }
        
        guard let responseData = data else {
          completionHandler(.failure(APIError.invalidData))
          return
        }
        
        completionHandler(.success(responseData))
      }
    }
    
    task.resume()
  }
}
