//
//  StateView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/24.
//

import UIKit

final class AlphaStateView: UIView {
  // MARK: - Constant
  struct Constant {
    enum StateLabel {
      static let textSize: CGFloat = 10
      static let spacing: UISpacing = .init(trailing:7)
    }
  }
  
  // MARK: - Properties
  private let stateLabel: UILabel = .init().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "10"
    $0.textColor = .black
    $0.font = UIFont.systemFont(ofSize: Constant.StateLabel.textSize)
  }
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupUI(with: stateLabel)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - Helper
extension AlphaStateView {
  func updateStateLabel(with text: String) {
    stateLabel.text = text
  }
}

// MARK: - LayoutSupport
extension AlphaStateView: LayoutSupport {
  func setConstraints() {
    NSLayoutConstraint.activate([
      stateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      stateLabel.trailingAnchor.constraint(
        equalTo: trailingAnchor,
        constant: -Constant.StateLabel.spacing.trailing)])
  }
}
