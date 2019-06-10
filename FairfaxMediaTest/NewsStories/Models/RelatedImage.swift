//
//  RelatedImage.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum RelatedImageType: String {
  case thumbnail
}

struct RelatedImage: Decodable {
  let url: URL
  let type: String
  
  private enum CodingKeys: String, CodingKey {
    case url
    case type
  }
  
  init(from decoder: Decoder) throws {
    do {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.url = try container.decode(URL.self, forKey: .url)
      self.type = try container.decode(String.self, forKey: .type)
    } catch {
      throw error
    }
  }
}
