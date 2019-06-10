//
//  StoryWebViewModelTests.swift
//  FairfaxMediaTestTests
//
//  Created by Alexey on 10/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import FairfaxMediaTest

class StoryWebViewModelTests: XCTestCase {
  
  func testShowWebViewURL() {
    let url = URL(string: "https://www.afr.com")!
    let sut = StoryWebViewModel(url: url)
    XCTAssertEqual(sut.url, url)
  }
}
