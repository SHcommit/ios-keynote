//
//  SlideMenuDetailView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/27.
//

import UIKit

final class SlideMenuDetailView: UIView {
  // MARK: - Constant
  struct Constant {
    enum InspectorView {
      static let width = KeynoteView
        .Constant
        .SlideMenuView
        .width
    }
  }
  
  // MARK: - UI Properties
  private let inspectorView = InspectorView()
  
  private let slideContainerView = SlideDetailContainerView()
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemGray
    setupSubviewUI(with: inspectorView, slideContainerView)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - Helper
extension SlideMenuDetailView {
  func prepareForReuse() {
    inspectorView.prepareInspectorView()
    slideContainerView.prepareSlideView()
  }
  
  func configure(with model: SlideModel) {
    switch model.state {
    case .rect(let rectModel):
      print(rectModel.description)
      inspectorView.configure(
        with: rectModel.alpha,
        color: UIColor(with: rectModel.rgb, alpha: rectModel.alpha))
      slideContainerView.configure(with: model)
    case .image(let imageStr):
      // TODO: - image config impl..
      print(imageStr)
    }
  }
}

// MARK: - LayoutSupport
extension SlideMenuDetailView: LayoutSupport {
  func setConstraints() {
    _=[slideContentViewConstraints,
       inspectorViewConstraints].map {
      NSLayoutConstraint.activate($0)
    }
  }
}

// MARK: - LayoutSupport helper
private extension SlideMenuDetailView {
  private var slideContentViewConstraints: [NSLayoutConstraint] {
    [slideContainerView.leadingAnchor.constraint(
      equalTo: leadingAnchor),
     slideContainerView.topAnchor.constraint(
      equalTo: topAnchor),
     slideContainerView.bottomAnchor.constraint(
      equalTo: bottomAnchor)]
  }
  
  private var inspectorViewConstraints: [NSLayoutConstraint] {
    [inspectorView.leadingAnchor.constraint(
      equalTo: slideContainerView.trailingAnchor),
     inspectorView.trailingAnchor.constraint(
      equalTo: trailingAnchor),
     inspectorView.topAnchor.constraint(
      equalTo: topAnchor),
     inspectorView.bottomAnchor.constraint(
      equalTo: bottomAnchor),
     inspectorView.widthAnchor.constraint(equalToConstant: Constant.InspectorView.width)]
  }
}
