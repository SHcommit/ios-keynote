//
//  InspectorView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class InspectorView: UIView {
  // MARK: - Constant
  struct Constant {
    enum BackgroundColorLabel {
      static let textSize: CGFloat = 16
      static let spacing: UISpacing = .init(leading:7, top: 7)
    }
    
    enum BackgroundColorStateLabel {
      static let textSize: CGFloat = 16
      static let spacing: UISpacing = .init(leading:7, top: 7, trailing: 7)
      static let bgColor: UIColor = .systemYellow
      static let innerVertiSpacing: CGFloat = 7
      static let radius: CGFloat = 7
    }
    
    enum AlphaLabel {
      static let textSize: CGFloat = 16
      static let spacing: UISpacing = .init(leading:7, top: 7*2)
    }
    
    enum AlphaView {
      static let spacing: UISpacing = .init(leading:7, top: 7, trailing: 7)
    }
  }
  
  enum setBGColorStateTypes {
    case setText(String)
    case setBgColor(UIColor)
    case setBgColorAlpha(Double)
  }
  
  var bgColorStateViewHeightWithVertiSpacing: CGFloat {
    backgroundColorStateLabel.sizeToFit()
    return backgroundColorStateLabel.bounds.height + Constant.BackgroundColorStateLabel.innerVertiSpacing * 2.0
  }
  
  // MARK: - UI Properties
  private let backgroundColorLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "배경색"
    $0.textColor = .black
    $0.font = .systemFont(
      ofSize: Constant.BackgroundColorLabel.textSize,
      weight: .regular)
  }
  
  private let backgroundColorStateLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "0x..."
    $0.font = .systemFont(ofSize: Constant.BackgroundColorStateLabel.textSize)
    $0.backgroundColor = Constant.BackgroundColorStateLabel.bgColor
    $0.textAlignment = .center
    $0.layer.cornerRadius = Constant.BackgroundColorStateLabel.radius
    $0.clipsToBounds = true
  }
  
  private let alphaLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "투명도"
    $0.font = .systemFont(
      ofSize: Constant.AlphaLabel.textSize,
      weight: .regular)
  }
  
  private lazy var alphaView = AlphaView(indexPath: indexPath)
  
  // MARK: - Properties
  var indexPath: IndexPath {
    guard
      let cell = superview as? UITableViewCell,
      let tableView = superview?.superview as? UITableView
    else {
      return .init(row: 0, section: 0)
    }
    return tableView.indexPath(for: cell) ?? .init(row: 0, section: 0)
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setupSubviewUI(
      with: backgroundColorLabel,
      backgroundColorStateLabel,
      alphaLabel,
      alphaView)
    bind()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(
        self,
        name: .AlphaViewStepperValueChanged,
        object: nil)
  }
}

// MARK: - @Objc Helper
extension InspectorView {
  @objc func setBgStateView(_ notification: Notification) {
    let userInfoKey = AlphaView.Constant.Stepper.notificatonCenterPostKey
    guard
      let userInfo = notification.userInfo,
      let message = userInfo[userInfoKey] as? (alpha: Int, indexPath: IndexPath)
    else {
      return
    }
    setBgColorStateView(with: .setBgColorAlpha(Double(message.alpha)/10.0))
  }
}

// MARK: - Helper
extension InspectorView {
  func configure(with bgColor: UIColor) {
    setBackgroundColorStateViewBgColor(with: bgColor)
  }
  
  func setBgColorStateView(with type: setBGColorStateTypes) {
    switch type {
    case .setText(let text):
      setBackgroundColorStateViewText(with: text)
    case .setBgColorAlpha(let alphaValue):
      setBackgroundColorStateViewBgColorAlpha(with: alphaValue)
    case .setBgColor(let color):
      setBackgroundColorStateViewBgColor(with: color)
    }
  }
}

// MARK: - Private helper
extension InspectorView {
  private func configureUI() {
    backgroundColor = .systemGray6
    translatesAutoresizingMaskIntoConstraints = false
    setBgColorStateViewTextReversal(with: 1.0)
  }
  
  private func setBackgroundColorStateViewText(with text: String) {
    DispatchQueue.main.async {
      self.backgroundColorStateLabel.text = text
    }
  }
  
  private func setBackgroundColorStateViewBgColor(with color: UIColor) {
    DispatchQueue.main.async {
      self.backgroundColorStateLabel.backgroundColor = color
    }
    setBackgroundColorStateViewText(with: "\(color.toHexString())")
  }
  
  private func setBackgroundColorStateViewBgColorAlpha(with alpha: Double) {
    DispatchQueue.main.async {
      let bgColor = self.backgroundColorStateLabel.backgroundColor
      self.backgroundColorStateLabel.backgroundColor = bgColor?.withAlphaComponent(alpha)
      self.setBgColorStateViewTextReversal(with: alpha)
    }
  }
  
  private func setBgColorStateViewTextReversal(with alpha: Double) {
    guard
      let bgColor = self.backgroundColorStateLabel.backgroundColor?.brightness()
    else { return }
    backgroundColorStateLabel
      .textColor = bgColor > 0.5 ? .black : .white
    let textColor = backgroundColorStateLabel.textColor
    if alpha < 0.5 && textColor == .white {
      backgroundColorStateLabel.textColor = .black
    } else if textColor == .black {
      backgroundColorStateLabel.textColor = .white
    }
  }
  
  func bind() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(setBgStateView),
      name: .AlphaViewStepperValueChanged,
      object: nil)
  }
}

// MARK: - LayoutSupport
extension InspectorView: LayoutSupport {
  func setConstraints() {
    _=[backgroundColorLabelConstraints,
       backgroundColorStateLabelConstraints,
       alphaLabelConstraints,
       alphaViewConstraitns
    ].map {
      NSLayoutConstraint.activate($0)
    }
  }
}

// MARK: - LayoutSupport helper
private extension InspectorView {
  var backgroundColorLabelConstraints: [NSLayoutConstraint] {
    [backgroundColorLabel.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.BackgroundColorLabel.spacing.leading),
     backgroundColorLabel.topAnchor.constraint(
      equalTo: topAnchor,
      constant: Constant.BackgroundColorLabel.spacing.top)]
  }
  
  var backgroundColorStateLabelConstraints: [NSLayoutConstraint] {
    [backgroundColorStateLabel.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.BackgroundColorStateLabel.spacing.leading),
     backgroundColorStateLabel.topAnchor.constraint(
      equalTo: backgroundColorLabel.bottomAnchor,
      constant: Constant.BackgroundColorStateLabel.spacing.top),
     backgroundColorStateLabel.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.BackgroundColorStateLabel.spacing.trailing),
     backgroundColorStateLabel.heightAnchor.constraint(
      equalToConstant: bgColorStateViewHeightWithVertiSpacing)]
  }
  
  var alphaLabelConstraints: [NSLayoutConstraint] {
    [alphaLabel.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.AlphaLabel.spacing.leading),
     alphaLabel.topAnchor.constraint(
      equalTo: backgroundColorStateLabel.bottomAnchor,
      constant: Constant.AlphaLabel.spacing.top)]
  }
  
  var alphaViewConstraitns: [NSLayoutConstraint] {
    [alphaView.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.AlphaView.spacing.leading),
     alphaView.topAnchor.constraint(
      equalTo: alphaLabel.bottomAnchor,
      constant: Constant.AlphaView.spacing.top),
     alphaView.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.AlphaView.spacing.trailing)]
  }
}
