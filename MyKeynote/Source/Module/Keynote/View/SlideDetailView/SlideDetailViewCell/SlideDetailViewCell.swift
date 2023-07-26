//
//  SlideDetailViewCell.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/25.
//

import UIKit

final class SlideDetailViewCell: UITableViewCell {
  // MARK: - Constant
  struct Constant {
    enum InspectorView {
      static let width = KeynoteView
        .Constant
        .SlideMenuView
        .width
    }
  }
  
  static let id = String(describing: SlideDetailViewCell.self)
  
  // MARK: - UI Properties
  private let inspectorView = InspectorView()
  
  private let slideContentView = SlideDetailContainerView()
  
  // MARK: - Lifecycle
  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviewUI(with: slideContentView, inspectorView)
    backgroundColor = .systemGray 
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - Helper
extension SlideDetailViewCell {
  func configure(with model: SlideModel) {
    slideContentView.configure(with: model)
    guard let rectModel = model.getinstance as? RectModel else { return }
    inspectorView.configure(with: .init(with: rectModel.rgb, alpha: rectModel.alpha))
  }
}

// MARK: - LayoutSupport
extension SlideDetailViewCell: LayoutSupport {
  func setConstraints() {
    _=[slideContentViewConstraints,
       inspectorViewConstraints].map {
      NSLayoutConstraint.activate($0)
    }
  }
}

// MARK: - LayoutSupport helper
private extension SlideDetailViewCell {
  private var slideContentViewConstraints: [NSLayoutConstraint] {
    [slideContentView.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor),
     slideContentView.topAnchor.constraint(
      equalTo: contentView.topAnchor),
     slideContentView.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor)]
  }
  
  private var inspectorViewConstraints: [NSLayoutConstraint] {
    [inspectorView.leadingAnchor.constraint(
      equalTo: slideContentView.trailingAnchor),
     inspectorView.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor),
     inspectorView.topAnchor.constraint(
      equalTo: contentView.topAnchor),
     inspectorView.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor),
     inspectorView.widthAnchor.constraint(equalToConstant: Constant.InspectorView.width)]
  }
}
