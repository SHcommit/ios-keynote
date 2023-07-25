//
//  SlideMenuViewCell.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/25.
//

import UIKit

final class SlideMenuViewCell: UITableViewCell {
  // MARK: - Constant
  static let id = String(describing: SlideMenuViewCell.self)
  
  // MARK: - UI Properties
  
  // MARK: - Lifecycle
  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

extension SlideMenuViewCell {
  
}
