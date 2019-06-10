//
//  NewsStoriesViewController.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import UIKit

final class NewsStoriesViewController: UIViewController {
  
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  
  private let viewModel = NewsStoriesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    viewModel.fetchNewsStories()
  }
}

extension NewsStoriesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfStories
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(type: NewsStoriesTableViewCell.self, forIndexPath: indexPath)
    cell.bind(viewModel.cellViewModel(for: indexPath.item))
    return cell
  }
}

extension NewsStoriesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectStory(at: indexPath.item)
  }
}

extension NewsStoriesViewController: NewsStoriesViewModelDelegate {
  
  func didLoadStories() {
    navigationItem.title = viewModel.title
    tableView.reloadData()
  }
  
  func didFailLoadStories(error: Error) {
    let alertController = UIAlertController(title: "Error",
                                            message: error.localizedDescription,
                                            preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
  
  func stopActivityIndicator() {
    activityIndicator.stopAnimating()
  }
  
  func show(url: URL) {
    let storyboard = UIStoryboard(name: "StoryWebView", bundle: nil)
    let identifier = String(describing: StoryWebViewController.self)
    
    if let storyWebViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? StoryWebViewController {
      storyWebViewController.viewModel = StoryWebViewModel(url: url)
      navigationController?.pushViewController(storyWebViewController, animated: true)
    }
  }
}
