//
//  SlideDetailContainerView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class SlideDetailContainerView: UIView {
  // MARK: - UI Properties
  private let slideView = SlideDetailContentView()
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setupSubviewUI(with: slideView)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}

// MARK: - Helper
extension SlideDetailContainerView {
  func configure(with model: SlideModel) {
    slideView.configure(with: model)
  }
  
  func prepareSlideView() {
    slideView.prepareSlideDetailContentView()
  }
}

// MARK: - Private helepr
extension SlideDetailContainerView {
  private func configureUI() {
    backgroundColor = .systemGray2
    translatesAutoresizingMaskIntoConstraints = false
  }
}

// MARK: - LayoutSupport
extension SlideDetailContainerView: LayoutSupport {
  func setConstraints() {
    NSLayoutConstraint.activate([
      slideView.leadingAnchor.constraint(equalTo: leadingAnchor),
      slideView.trailingAnchor.constraint(equalTo: trailingAnchor),
      slideView.centerYAnchor.constraint(equalTo: centerYAnchor),
      slideView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)])
  }
}
