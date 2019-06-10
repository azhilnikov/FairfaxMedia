//
//  Asset.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct Asset: Decodable {
  
  var thumbnailURL: URL? {
    return relatedImages.first(where: { $0.type == RelatedImageType.thumbnail.rawValue })?.url
  }
  
  let url: URL
  let headline: String
  let abstract: String
  let author: String
  let relatedImages: [RelatedImage]
  let timeStamp: TimeInterval
  
  private enum CodingKeys: String, CodingKey {
    case url
    case headline
    case abstract = "theAbstract"
    case author = "byLine"
    case relatedImages
    case timeStamp
  }
  
  init(from decoder: Decoder) throws {
    do {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.url = try container.decode(URL.self, forKey: .url)
      self.headline = try container.decode(String.self, forKey: .headline)
      self.abstract = try container.decode(String.self, forKey: .abstract)
      self.author = try container.decode(String.self, forKey: .author)
      self.relatedImages = try container.decode([RelatedImage].self, forKey: .relatedImages)
      self.timeStamp = try container.decode(TimeInterval.self, forKey: .timeStamp)
    } catch {
      throw error
    }
  }
}
