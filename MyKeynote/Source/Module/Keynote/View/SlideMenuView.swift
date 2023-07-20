//
//  SlideMenuView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideMenuView: UIView {
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray6
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}
