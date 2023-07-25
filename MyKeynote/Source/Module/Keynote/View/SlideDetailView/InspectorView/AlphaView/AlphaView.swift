//
//  AlphaView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/24.
//

import UIKit

final class AlphaView: UIView {
  // MARK: - Constant
  struct Constant {
    enum Stepper {
      static let spacing: UISpacing = .init(leading: 7)
      static let minValue: Double = Double(AppSetting.UIConstAlpha.minAlpha)
      static let maxValue: Double = Double(AppSetting.UIConstAlpha.maxAlpha)
      static let notificatonCenterPostKey: some Hashable = String(
        describing: AlphaView.Constant.Stepper.self)
    }
  }
  
  // MARK: - UI Properties
  private let stateView = AlphaStateView()
  
  private lazy var stepper: UIStepper = UIStepper().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.value = Constant.Stepper.maxValue
    $0.minimumValue = Constant.Stepper.minValue
    $0.maximumValue = Constant.Stepper.maxValue
    $0.wraps = false
    $0.addTarget(
      self,
      action: #selector(didChangedStepperValue),
      for: .valueChanged)
  }
  
  // MARK: - Properties
  private var indexPath: IndexPath!
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupSubviewUI(with: stateView, stepper)
  }
  
  init(frame: CGRect, indexPath: IndexPath) {
    self.indexPath = indexPath
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupSubviewUI(with: stateView, stepper)
  }
  
  convenience init(indexPath: IndexPath) {
    self.init(frame: .zero, indexPath: indexPath)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - @objc helper
extension AlphaView {
  @objc func didChangedStepperValue(_ sender: UIStepper) {
    let changedValue = Int(sender.value)
    setStateView(with: "\(changedValue)")
    notifyStepperValueChangedToObservers(with: changedValue)
  }
}

// MARK: - Private helper
private extension AlphaView {
  func setStateView(with text: String) {
    stateView.setStateLabel(with: text)
  }
  
  func notifyStepperValueChangedToObservers(with alpha: Int) {
    let key: some Hashable = Constant
      .Stepper
      .notificatonCenterPostKey

    let userInfo: [some Hashable: (alpha: Int, indexPath: IndexPath)] = [key: (alpha, indexPath)]
    
    NotificationCenter.default.post(
      name: .AlphaViewStepperValueChanged,
      object: nil,
      userInfo: userInfo)
  }
}

// MARK: - LayoutSupport
extension AlphaView: LayoutSupport {
  func setConstraints() {
    _=[stateViewConstraints, stepperConstraints].map {
      NSLayoutConstraint.activate($0)
    }
  }
}

// MARK: - Layout support helper
private extension AlphaView {
  var stateViewConstraints: [NSLayoutConstraint] {
    [stateView.leadingAnchor.constraint(equalTo: leadingAnchor),
     stateView.topAnchor.constraint(equalTo: topAnchor),
     stateView.bottomAnchor.constraint(equalTo: bottomAnchor)]
  }
  
  var stepperConstraints: [NSLayoutConstraint] {
    [stepper.leadingAnchor.constraint(
      equalTo: stateView.trailingAnchor,
      constant: Constant.Stepper.spacing.leading),
     stepper.topAnchor.constraint(equalTo: topAnchor),
     stepper.trailingAnchor.constraint(equalTo: trailingAnchor),
     stepper.bottomAnchor.constraint(equalTo: bottomAnchor)]
  }
}
