//
//  SlideContentView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideContentView: UIView {
  
  private let slideView = SlideView()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray2
    translatesAutoresizingMaskIntoConstraints = false
    setupUI(with: slideView)
    let rectModel = RectModel(uniqueID: "", width: 250, rgba: .init(red: 0, green: 0, blue: 0, alpha: .init(alpha: 0)))
    let slideModel = SlideModel(rectModel: rectModel, state: .rect)
    slideView.configure(with: slideModel)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}

extension SlideContentView: LayoutSupport {
  func setConstraints() {
    addSubview(slideView)
    NSLayoutConstraint.activate([
      slideView.leadingAnchor.constraint(equalTo: leadingAnchor),
      slideView.trailingAnchor.constraint(equalTo: trailingAnchor),
      slideView.centerYAnchor.constraint(equalTo: centerYAnchor),
      slideView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)])
  }
}
