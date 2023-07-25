//
//  SlideDetailView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/25.
//

import UIKit

final class SlideDetailView: UITableView {
  // MARK: - Lifecycle
  private override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init(with rowHeight: CGFloat) {
    self.init(frame: .zero, style: .plain)
    backgroundColor = .systemPink
    self.rowHeight = rowHeight
  }
}

// MARK: - Private helper
private extension SlideDetailView {
  func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    register(
      SlideDetailViewCell.self,
      forCellReuseIdentifier: SlideDetailViewCell.id)
    // 이거 왜 안돼
    rowHeight = bounds.height
  }
}
