//
//  LayoutSupport.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

/// UIView's layout support
protocol LayoutSupport {
  /// Set subviews constraints in root view
  func setConstraints()
}

extension LayoutSupport where Self: UIView {
  func setupUI(with subviews: UIView...) {
    addSubviews(subviews)
    setConstraints()
  }
  
  /// Add subviews in root view
  func addSubviews(_ views: UIView...) {
    self.addSubviews(views)
  }
}
