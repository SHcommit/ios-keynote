//
//  SlideMenuView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideMenuView: UITableView {
  // MARK: - Constant
  enum slideMenuViewCellTypes {
    case rect
    case image
    
    var imageName: String {
      switch self {
      case .image: return "slideMenuImage"
      case .rect: return "slideMenuRect"
      }
    }
  }
  
  // MARK: - Lifecycle
  private override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero, style: .plain)
  }
}

// MARK: - Private helper
private extension SlideMenuView {
  func configureUI() {
    backgroundColor = .systemGray6
    translatesAutoresizingMaskIntoConstraints = false
    register(
      SlideMenuViewCell.self,
      forCellReuseIdentifier: SlideMenuViewCell.id)
    rowHeight = SlideMenuViewCell.Constant.intrinsicContentSize.height
  }
}
