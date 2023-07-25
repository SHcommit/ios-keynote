//
//  SlideContentView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideContentView: UIView {
  // MARK: - Properties
  private let slideView = SlideView()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviewUI(with: slideView)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}

extension SlideContentView {
  func setRectColor(with: UIColor) {
    slideView.setRectViewColor(with: with)
  }
  
  func setRectColorAlpha(with: Double) {
    slideView.setRectViewAlpah(with: with)
  }
}

// MARK: - Private helepr
extension SlideContentView {
  func configureUI() {
    backgroundColor = .systemGray2
    translatesAutoresizingMaskIntoConstraints = false
    setupSubviewUI(with: slideView)
    let rectModel = RectModel(uniqueID: "", width: 250, rgba: .init(red: 0, green: 0, blue: 0, alpha: .init(alpha: 0)))
    let slideModel = SlideModel(rectModel: rectModel, state: .rect)
    slideView.configure(with: slideModel)
  }
}

// MARK: - LayoutSupport
extension SlideContentView: LayoutSupport {
  func setConstraints() {
    NSLayoutConstraint.activate([
      slideView.leadingAnchor.constraint(equalTo: leadingAnchor),
      slideView.trailingAnchor.constraint(equalTo: trailingAnchor),
      slideView.centerYAnchor.constraint(equalTo: centerYAnchor),
      slideView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)])
  }
}
