//
//  IsLoadableTableViewCell.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//
import SkeletonView

class IsLoadableTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  var isLoading: Bool = false {
    didSet {
      toggleSceleton()
    }
  }
  
  // MARK: - Lifecycle events
  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    toggleSceleton()
  }
  
  private func toggleSceleton() {
    if isLoading {
      self.showAnimatedGradientSkeleton()
    } else {
      self.hideSkeleton()
    }
  }
}
