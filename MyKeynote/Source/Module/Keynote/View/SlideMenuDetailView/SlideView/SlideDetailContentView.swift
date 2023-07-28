//
//  SlideView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideDetailContentView: UIView {
  // MARK: - UI Properties
  private lazy var rectView: UIView? = UIView(frame: .zero).set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemYellow
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.8
  }
  
  private var rectViewConstraints: [NSLayoutConstraint]?
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
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
extension SlideDetailContentView {
  @objc func setBgStateView(_ notification: Notification) {
    let userInfoKey = AlphaView.Constant.Stepper.notificatonCenterPostKey
    guard
      let userInfo = notification.userInfo,
      let (alpha, _) = userInfo[userInfoKey] as? (alpha: Int, uniqueId: String)
    else {
      return
    }
    setRectViewAlpah(with: Double(alpha)/10.0)
  }
}

// MARK: - Helper
extension SlideDetailContentView{
  func configure(with data: SlideType) {
    switch data.state {
    case .rect(let rectModel):
      guard let rectView = rectView else { return }
      if !subviews.contains(where: {$0 === rectView} ) {
        addSubview(rectView)
        NSLayoutConstraint.activate(
          rectViewContraints(with: rectModel))
        bind()
      }
      setRectViewAlpah(with: rectModel.alpha/10.0)
      setRectViewColor(with: UIColor(with: rectModel.rgb, alpha: (rectModel.alpha)/10.0))
      let rectSize = CGSize(width: rectModel.width, height: rectModel.width)
      setRectViewSize(with: rectSize)
      
    default:
      break
    }
  }
  
  func prepareSlideDetailContentView() {
    DispatchQueue.main.async {
      self.rectView?.backgroundColor = .white
    }
  }
}

// MARK: - Private helper
private extension SlideDetailContentView {
  func bind() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(setBgStateView),
      name: .AlphaViewStepperValueChanged,
      object: nil)
  }

  func setRectViewAlpah(with: CGFloat) {
    DispatchQueue.main.async {
      let bgColor = self.rectView?.backgroundColor
      self.rectView?.backgroundColor = bgColor?.withAlphaComponent(with)
    }
  }
  
  func setRectViewColor(with: UIColor) {
    DispatchQueue.main.async {
      self.rectView?.backgroundColor = with
    }
  }
  
  func setRectViewSize(with: CGSize) {
    DispatchQueue.main.async {
      guard
        let rectViewConstraints = self.rectViewConstraints
      else {
        return
      }
      _=rectViewConstraints.map{ $0.isActive = false }
      rectViewConstraints[0].constant = with.width
      rectViewConstraints[1].constant = with.height
      _=rectViewConstraints.map { $0.isActive = true }
    }
  }
  
  func rectViewContraints(with model: RectModel) -> [NSLayoutConstraint]
  {
    guard let rectView = rectView else { return [] }
    rectViewConstraints = [
      rectView.widthAnchor.constraint(
        equalToConstant: CGFloat(model.width)),
      rectView.heightAnchor.constraint(
        equalToConstant: CGFloat(model.width))]
    return [
      rectView.centerXAnchor.constraint(
        equalTo: centerXAnchor),
      rectView.centerYAnchor.constraint(
        equalTo: centerYAnchor)] + rectViewConstraints!
  }
}
