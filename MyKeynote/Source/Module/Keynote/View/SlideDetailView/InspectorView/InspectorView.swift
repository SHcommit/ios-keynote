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
  
  private let alphaView = AlphaView()
  
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
      let message = userInfo[userInfoKey] as? Int
    else {
      return
    }
    setBgColorStateView(with: .setBgColorAlpha(Double(message)/10.0))
  }
}

// MARK: - Helper
extension InspectorView {
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
  }
  
  private func setBackgroundColorStateViewBgColorAlpha(with alpha: Double) {
    DispatchQueue.main.async {
      let bgColor = self.backgroundColorStateLabel.backgroundColor
      self.backgroundColorStateLabel.backgroundColor = bgColor?.withAlphaComponent(alpha)
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
    print(bgColorStateViewHeightWithVertiSpacing)
    return [backgroundColorStateLabel.leadingAnchor.constraint(
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
