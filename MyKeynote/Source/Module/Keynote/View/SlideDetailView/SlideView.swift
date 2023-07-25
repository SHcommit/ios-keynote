//
//  SlideView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideView: UIView {
  // MARK: - Properties
  private lazy var rectView: UIView? = UIView(frame: .zero).set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemYellow
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.5
  }
  
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
}

// MARK: - Helper
extension SlideView{
  func configure(with data: SlideModel) {
    switch data.state {
    case .rect:
      guard let rectModel = data.rectModel else { return }
      guard let rectView = rectView else { return }
      if !subviews.contains(where: {$0 === rectView} ) {
        addSubview(rectView)
        NSLayoutConstraint.activate(
          rectViewContraints(with: rectModel))
      }
      
    }
  }
  
  func setRectViewAlpah(with: Double) {
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
}

// MARK: - Private helper
private extension SlideView {
  func setRectViewBgColor(with model: RectModel) {
    DispatchQueue.main.async {
      let bgColor = self.rectView?.backgroundColor?.withAlphaComponent(model.alpha)
      self.rectView?.backgroundColor = bgColor
    }
  }
  
  func rectViewContraints(with model: RectModel) -> [NSLayoutConstraint]
  {
    guard let rectView = rectView else { return [] }
    return [
      rectView.centerXAnchor.constraint(
        equalTo: centerXAnchor),
      rectView.centerYAnchor.constraint(
        equalTo: centerYAnchor),
      rectView.widthAnchor.constraint(
        equalToConstant: CGFloat(model.width)),
      rectView.heightAnchor.constraint(
        equalToConstant: CGFloat(model.width))]
  }
}
