//
//  NewsStoriesViewModelTests.swift
//  FairfaxMediaTestTests
//
//  Created by Alexey on 10/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import FairfaxMediaTest

class NewsStoriesViewModelTests: XCTestCase {
  
  private var sut: NewsStoriesViewModel!
  private var newsStories: NewsStories!
  private var viewController: NewsStoriesViewControllerMock!
  
  override func setUp() {
    super.setUp()
    
    viewController = NewsStoriesViewControllerMock()
    
    let jsonData = TestsHelper.loadJSON(from: "FairfaxMedia")!
    let decoder = JSONDecoder()
    
    newsStories = try! decoder.decode(NewsStories.self, from: jsonData)
    sut = NewsStoriesViewModel(newsStories: newsStories)
    sut.delegate = viewController
  }
  
  func testNewsStoriesTitle() {
    XCTAssertEqual(sut.title, newsStories.title)
  }
  
  func testNewsStoriesNumberOfStories() {
    XCTAssertEqual(sut.numberOfStories, newsStories.assets.count)
  }
  
  func testDidLoadStories() {
    sut.delegate?.didLoadStories()
    XCTAssertTrue(viewController.isDidLoadStoriesCalled)
  }
  
  func testDidFailLoadStories() {
    sut.delegate?.didFailLoadStories(error: APIError.invalidData)
    XCTAssertTrue(viewController.isDidFailLoadStoriesCalled)
  }
  
  func testActivityIndicatorStopped() {
    sut.delegate?.stopActivityIndicator()
    XCTAssertTrue(viewController.isActivityIndicatorStopped)
  }
  
  func testCellViewModel() {
    for (index, asset) in newsStories.assets.enumerated() {
      let cellViewModel = sut.cellViewModel(for: index)
      XCTAssertEqual(cellViewModel?.title, asset.headline)
      XCTAssertEqual(cellViewModel?.abstruct, asset.abstract)
      XCTAssertEqual(cellViewModel?.author, asset.author)
      XCTAssertEqual(cellViewModel?.imageURL, asset.thumbnailURL)
    }
  }
  
  func testThumbnailURL() {
    let cellViewModel = sut.cellViewModel(for: 0)
    XCTAssertEqual(cellViewModel?.imageURL?.absoluteString, "https://www.fairfaxstatic.com.au/content/dam/images/h/1/f/6/f/p/image.related.thumbnail.375x250.p51vks.13zzqx.png/1559910471174.jpg")
  }
  
  func testCellViewModelIsNil() {
    let cellViewModel = sut.cellViewModel(for: sut.numberOfStories)
    XCTAssertNil(cellViewModel)
  }
  
  func testShowStoryWebView() {
    sut.selectStory(at: 0)
    XCTAssertTrue(viewController.isShowURLCalled)
  }
  
  func testDoNotShowStoryWebView() {
    sut.selectStory(at: sut.numberOfStories)
    XCTAssertFalse(viewController.isShowURLCalled)
  }
  
  func testShowStoryWebViewURL() {
    for (item, asset) in newsStories.assets.enumerated() {
      sut.selectStory(at: item)
      XCTAssertEqual(viewController.url?.absoluteString, asset.url.absoluteString)
    }
  }
}

class NewsStoriesViewControllerMock: NewsStoriesViewModelDelegate {
  
  private(set) var isDidLoadStoriesCalled = false
  private(set) var isDidFailLoadStoriesCalled = false
  private(set) var isActivityIndicatorStopped = false
  private(set) var isShowURLCalled = false
  private(set) var url: URL?
  
  func didLoadStories() {
    isDidLoadStoriesCalled = true
  }
  
  func didFailLoadStories(error: Error) {
    isDidFailLoadStoriesCalled = true
  }
  
  func stopActivityIndicator() {
    isActivityIndicatorStopped = true
  }
  
  func show(url: URL) {
    isShowURLCalled = true
    self.url = url
  }
}
