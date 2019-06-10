//
//  UIImageViewExtension.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  
  func setCachedImage(for url: URL) {
    let imageURL = url
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
      image = imageFromCache
      return
    }
    
    let request = APIRequest(url: url)
    request.fetch() { result in
      
      switch result {
      case .success(let data):
        if let imageToCache = UIImage(data: data) {
          imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
          
          if imageURL == url {
            self.image = imageToCache
          }
        }
        
      default:
        break
      }
    }
  }
}
