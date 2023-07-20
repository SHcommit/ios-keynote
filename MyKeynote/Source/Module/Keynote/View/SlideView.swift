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
      addSubview(rectView)
      NSLayoutConstraint.activate([
        rectView.centerXAnchor.constraint(equalTo: centerXAnchor),
        rectView.centerYAnchor.constraint(equalTo: centerYAnchor),
        rectView.widthAnchor.constraint(equalToConstant: CGFloat(rectModel.width)),
        rectView.heightAnchor.constraint(equalToConstant: CGFloat(rectModel.width))])
    }
  }
}
