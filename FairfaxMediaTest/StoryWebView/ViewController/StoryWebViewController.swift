//
//  StoryWebViewController.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 10/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import WebKit

final class StoryWebViewController: UIViewController {
  
  @IBOutlet private var webView: WKWebView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  
  var viewModel: StoryWebViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    webView.navigationDelegate = self
    if let url = viewModel?.url {
      webView.load(URLRequest(url: url))
    }
  }
}

extension StoryWebViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    activityIndicator.stopAnimating()
  }
}
