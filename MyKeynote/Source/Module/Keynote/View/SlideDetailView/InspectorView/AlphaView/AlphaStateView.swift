//
//  AlphaStateView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/24.
//

import UIKit

final class AlphaStateView: UIView {
  // MARK: - Constant
  struct Constant {
    static let radius: CGFloat = 7
    static let borderColor: CGColor = UIColor.lightGray.cgColor
    static let borderWidth: CGFloat = 0.5
    static let bgColor: UIColor = .white
    
    enum StateLabel {
      static let textSize: CGFloat = 13
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
  private override init(frame: CGRect)  {
    super.init(frame: frame)
    configureUI()
    setupSubviewUI(with: stateLabel)
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
  func setStateLabel(with text: String) {
    DispatchQueue.main.async {
      self.stateLabel.text = text
    }
  }
  
  private func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = Constant.bgColor
    layer.cornerRadius = Constant.radius
    layer.borderColor = Constant.borderColor
    layer.borderWidth = Constant.borderWidth
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
