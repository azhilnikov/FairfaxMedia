//
//  NewsStoriesTableViewCell.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import UIKit

final class NewsStoriesTableViewCell: UITableViewCell {
  
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var abstractLabel: UILabel!
  @IBOutlet private var authorLabel: UILabel!
  @IBOutlet private var thumbnail: UIImageView!
  
  func bind(_ viewModel: NewsStoriesTableViewCellViewModel?) {
    titleLabel.text = viewModel?.title
    abstractLabel.text = viewModel?.abstruct
    authorLabel.text = viewModel?.author
    
    if let url = viewModel?.imageURL {
      thumbnail.setCachedImage(for: url)
    }
  }
}
