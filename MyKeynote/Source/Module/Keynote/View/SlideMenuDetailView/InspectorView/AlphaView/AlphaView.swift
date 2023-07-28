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
  
  private var stepper: UIStepper!
  
  // MARK: - Properties
  private var uniqueId: String?
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    stepper = makeStepper()
    setupSubviewUI(with: stateView, stepper)
  }
  required init?(coder: NSCoder) {
    uniqueId = ""
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

// MARK: - Helper
extension AlphaView {
  func configure(with alpha: Double, uniqueId: String) {
    let alphaStr = String(Int(alpha*10))
    setStateView(with: alphaStr)
    setUniqueId(with: uniqueId)
    setStepper(with: Double(alpha*10)) 
  }
  
  func setStateView(with text: String) {
    stateView.setStateLabel(with: text)
  }
  
  func setUniqueId(with uniqueId: String) {
    self.uniqueId = uniqueId
    stepper.addTarget(
      self,
      action: #selector(didChangedStepperValue),
      for: .valueChanged)
  }
  
  func setStepper(with alphaValue: Double) {
    stepper.value = alphaValue
  }
}

// MARK: - Private helper
private extension AlphaView {
  func notifyStepperValueChangedToObservers(with alpha: Int) {
    let key: some Hashable = Constant
      .Stepper
      .notificatonCenterPostKey

    let userInfo: [some Hashable: (alpha: Int, uniqueId: String)] = [key: (alpha, uniqueId ?? "")]
    
    NotificationCenter.default.post(
      name: .AlphaViewStepperValueChanged,
      object: nil,
      userInfo: userInfo)
  }
  
  func makeStepper() -> UIStepper {
    return UIStepper().set {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.value = Constant.Stepper.maxValue
      $0.minimumValue = Constant.Stepper.minValue
      $0.maximumValue = Constant.Stepper.maxValue
      $0.wraps = false
    }
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
