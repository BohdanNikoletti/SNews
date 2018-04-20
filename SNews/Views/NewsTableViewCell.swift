//
//  NewsTableViewCell.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class NewsTableViewCell: IsLoadableTableViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak private var posterImage: UIImageView!
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var subTitleLabel: UILabel!
  
  // MARK: - Propertie listeners
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  var subTitle: String? {
    didSet {
      subTitleLabel.text = subTitle
    }
  }
  
  var poster: UIImage? {
    didSet {
      posterImage.image = poster ?? #imageLiteral(resourceName: "empty-image")
    }
  }
  
  // MARK: - Lifecycle events
  override func layoutSubviews() {
    super.layoutSubviews()
    posterImage.layer.cornerRadius = 5
  }
  
}
