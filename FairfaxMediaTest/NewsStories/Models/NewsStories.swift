//
//  NewsStories.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct NewsStories: Decodable {
  let title: String
  let assets: [Asset]
  
  private enum CodingKeys: String, CodingKey {
    case title = "displayName"
    case assets
  }
  
  init(from decoder: Decoder) throws {
    do {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.title = try container.decode(String.self, forKey: .title)
      self.assets = try container.decode([Asset].self, forKey: .assets)
    } catch {
      throw error
    }
  }
}

extension NewsStories {
  
  init() {
    title = ""
    assets = []
  }
}
