//
//  NewsStoriesProvider.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

final class NewsStoriesProvider {
  
  func fetch(url: String, completion: @escaping (NewsStories?, Error?) -> Void) {
    guard let url = URL(string: url) else {
      completion(nil, APIError.invalidURL)
      return
    }
    
    let request = APIRequest(url: url)
    request.fetch() { [weak self] result in
      
      switch result {
      case .success(let data):
        do {
          let newsStories = try self?.decode(from: data)
          completion(newsStories, nil)
        } catch {
          completion(nil, error)
        }
        
      case .failure(let error):
        completion(nil, error)
      }
    }
  }
  
  private func decode(from data: Data) throws -> NewsStories {
    let decoder = JSONDecoder()
    
    do {
      let newsStories = try decoder.decode(NewsStories.self, from: data)
      return newsStories
    } catch {
      throw error
    }
  }
}
