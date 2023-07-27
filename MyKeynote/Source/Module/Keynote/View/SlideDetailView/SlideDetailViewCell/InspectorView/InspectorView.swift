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
    enum RectColorTitleLabel {
      static let textSize: CGFloat = 16
      static let spacing: UISpacing = .init(leading:7, top: 7)
    }
    
    enum RectColorHexLabel {
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
    case setRectColorHexLabelColor(UIColor)
    case setRectColorHexLabelBgAlpha(Double)
    case setRectColorHexLabelText(String)
  }
  
  var bgColorStateViewHeightWithVertiSpacing: CGFloat {
    rectColorHexLabel.sizeToFit()
    return rectColorHexLabel.bounds.height + Constant.RectColorHexLabel.innerVertiSpacing * 2.0
  }
  
  // MARK: - UI Properties
  private let rectColorTitleLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "배경색"
    $0.textColor = .black
    $0.font = .systemFont(
      ofSize: Constant.RectColorTitleLabel.textSize,
      weight: .regular)
  }
  
  private let rectColorHexLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "0x..."
    $0.font = .systemFont(ofSize: Constant.RectColorHexLabel.textSize)
    $0.backgroundColor = Constant.RectColorHexLabel.bgColor
    $0.textAlignment = .center
    $0.layer.cornerRadius = Constant.RectColorHexLabel.radius
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
      with: rectColorTitleLabel,
      rectColorHexLabel,
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
    setBgColorStateView(with: .setRectColorHexLabelBgAlpha(Double(message.alpha)/10.0))
  }
}

// MARK: - Helper
extension InspectorView {
  func configure(with alpha: Double, color: UIColor) {
    let alphaStr = String(Int(alpha))
    let types: [setBGColorStateTypes] = [
      .setRectColorHexLabelColor(color),
      .setRectColorHexLabelBgAlpha(alpha),
      .setRectColorHexLabelText(color.toHexString())]
    
    _=types.map {
      setBgColorStateView(with: $0)
    }
  setAlphaViewAlphaValueState(with: alphaStr)
  }
  
  func setBgColorStateView(with type: setBGColorStateTypes) {
    switch type {
    case .setRectColorHexLabelBgAlpha(let alphaValue):
      setRectColorHexLabelBgAlpha(with: alphaValue)
    case .setRectColorHexLabelColor(let color):
      setRectColorHexLabelColor(with: color)
    case .setRectColorHexLabelText(let bgColorHexStr):
      setRectColorHexLabelText(with: bgColorHexStr)
    }
  }
  
  func prepareInspectorView() {
    rectColorHexLabel.text = ""
    rectColorHexLabel.backgroundColor = .white
    alphaView.setStateView(with: "")
    
  }
}

// MARK: - Private helper
extension InspectorView {
  private func configureUI() {
    backgroundColor = .systemGray6
    translatesAutoresizingMaskIntoConstraints = false
    setBgColorStateViewTextReversal(with: 1.0)
  }
  
  private func setRectColorHexLabelText(with text: String) {
    DispatchQueue.main.async {
      self.rectColorHexLabel.text = text
    }
  }
  
  private func setRectColorHexLabelColor(with color: UIColor) {
    DispatchQueue.main.async {
      self.rectColorHexLabel.backgroundColor = color
    }
      setRectColorHexLabelText(with: "\(color.toHexString())")
  }
  
  private func setRectColorHexLabelBgAlpha(with alpha: Double) {
    DispatchQueue.main.async {
      let bgColor = self.rectColorHexLabel.backgroundColor
      self.rectColorHexLabel.backgroundColor = bgColor?.withAlphaComponent(alpha)
      self.setBgColorStateViewTextReversal(with: alpha)
    }
  }
  
  private func setBgColorStateViewTextReversal(with alpha: Double) {
    guard
      let bgColor = self.rectColorHexLabel.backgroundColor?.brightness()
    else { return }
    rectColorHexLabel
      .textColor = bgColor > 0.5 ? .black : .white
    let textColor = rectColorHexLabel.textColor
    if alpha < 0.5 && textColor == .white {
      rectColorHexLabel.textColor = .black
    } else if textColor == .black {
      rectColorHexLabel.textColor = .white
    }
  }
  
  private func setAlphaViewAlphaValueState(with alphaStr: String) {
    alphaView.setStateView(with: alphaStr)
  }
  
  private func setRectColorHexLabel(with hexString: String) {
    DispatchQueue.main.async {
      self.rectColorHexLabel.text = hexString
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
    _=[rectColorTitleLabelConstraints,
       RectColorHexLabelConstraints,
       alphaLabelConstraints,
       alphaViewConstraitns
    ].map {
      NSLayoutConstraint.activate($0)
    }
  }
}

// MARK: - LayoutSupport helper
private extension InspectorView {
  var rectColorTitleLabelConstraints: [NSLayoutConstraint] {
    [rectColorTitleLabel.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.RectColorTitleLabel.spacing.leading),
     rectColorTitleLabel.topAnchor.constraint(
      equalTo: topAnchor,
      constant: Constant.RectColorTitleLabel.spacing.top)]
  }
  
  var RectColorHexLabelConstraints: [NSLayoutConstraint] {
    [rectColorHexLabel.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.RectColorHexLabel.spacing.leading),
     rectColorHexLabel.topAnchor.constraint(
      equalTo: rectColorTitleLabel.bottomAnchor,
      constant: Constant.RectColorHexLabel.spacing.top),
     rectColorHexLabel.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.RectColorHexLabel.spacing.trailing),
     rectColorHexLabel.heightAnchor.constraint(
      equalToConstant: bgColorStateViewHeightWithVertiSpacing)]
  }
  
  var alphaLabelConstraints: [NSLayoutConstraint] {
    [alphaLabel.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.AlphaLabel.spacing.leading),
     alphaLabel.topAnchor.constraint(
      equalTo: rectColorHexLabel.bottomAnchor,
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
