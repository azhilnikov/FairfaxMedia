//
//  TestHelper.swift
//  FairfaxMediaTestTests
//
//  Created by Alexey on 10/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class TestsHelper {
  
  class func loadJSON(from fileName: String) -> Data? {
    guard let url = Bundle(for: TestsHelper.self).url(forResource: fileName, withExtension: "json") else {
      return nil
    }
    
    guard let data = try? Data(contentsOf: url) else { return nil }
    return data
  }
}
