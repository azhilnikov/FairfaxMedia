//
//  NewsStoriesViewModel.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol NewsStoriesViewModelDelegate: class {
  func didLoadStories()
  func didFailLoadStories(error: Error)
  func stopActivityIndicator()
  func show(url: URL)
}

final class NewsStoriesViewModel {
  
  var numberOfStories: Int {
    return assets?.count ?? 0
  }
  
  var delegate: NewsStoriesViewModelDelegate?
  private(set) var title: String?
  
  private var assets: [Asset]?
  private let newsStoriesProvider = NewsStoriesProvider()
  private let newsStoriesURL = "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full"
  
  init(newsStories: NewsStories = NewsStories()) {
    self.title = newsStories.title
    self.assets = newsStories.assets
  }
  
  func fetchNewsStories() {
    newsStoriesProvider.fetch(url: newsStoriesURL) { [weak self] newsStories, error in
      
      self?.delegate?.stopActivityIndicator()
      
      if let error = error {
        self?.delegate?.didFailLoadStories(error: error)
        return
      }
      
      self?.title = newsStories?.title
      self?.assets = newsStories?.assets.sorted(by: { $0.timeStamp > $1.timeStamp } )
      self?.delegate?.didLoadStories()
    }
  }
  
  func cellViewModel(for item: Int) -> NewsStoriesTableViewCellViewModel? {
    guard contains(item: item), let asset = assets?[item] else {
      return nil
    }
    
    let cellViewModel = NewsStoriesTableViewCellViewModel(title: asset.headline,
                                                          abstruct: asset.abstract,
                                                          author: asset.author,
                                                          imageURL: asset.thumbnailURL)
    return cellViewModel
  }
  
  func selectStory(at item: Int) {
    if contains(item: item), let url = assets?[item].url {
      delegate?.show(url: url)
    }
  }
  
  private func contains(item: Int) -> Bool {
    return assets?.indices.contains(item) == true
  }
}
