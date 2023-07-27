//
//  SlideThumbnailView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/26.
//

import UIKit

final class SlideThumbnailView: UIView {
  // MARK: - Constant
  struct Constant {
    static let corderRadius: CGFloat = 7
    
    enum ImageView {
      static let spacing: UISpacing = .init(leading: 7, top: 7,trailing: 7, bottom: 7)
      
      static let selectedBGColor: UIColor = UIColor.colorWithHex("#ffba47")!.withAlphaComponent(0.5)
    }
  }
  // MARK: - UI Properties
  private let imageView: UIImageView = .init(image: nil).set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFit
    $0.layer.cornerRadius = Constant.corderRadius
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.cornerRadius = Constant.corderRadius
    //backgroundColor = .lightGray.withAlphaComponent(0.5)
    translatesAutoresizingMaskIntoConstraints = false
    setupSubviewUI(with: imageView)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}

// MARK: - Helper
extension SlideThumbnailView {
  func configure(with: UIImage, selected: Bool) {
    setImageView(with: with)
    setImageViewBG(with: selected)
  }
  
  func setImageViewBG(with: Bool) {
    let color: UIColor = with ? Constant.ImageView.selectedBGColor : .clear
    DispatchQueue.main.async {
      UIView.animate(
        withDuration: 0.55,
        delay: 0,
        options: [.curveEaseInOut]) {
          self.imageView.backgroundColor = color
        }
    }
  }
}

// MARK: - Private helper
private extension SlideThumbnailView {
  func setImageView(with image: UIImage) {
    DispatchQueue.main.async {
      self.imageView.image = image
    }
  }
}

// MARK: - LayoutSupport
extension SlideThumbnailView: LayoutSupport {
  func setConstraints() {
    _=[imageViewConstraints].map {
      NSLayoutConstraint.activate($0)
    }
  }
}

// MARK: - LayoutSupport helper
private extension SlideThumbnailView {
  var imageViewConstraints: [NSLayoutConstraint] {
    [imageView.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.ImageView.spacing.leading),
     imageView.topAnchor.constraint(
      equalTo: topAnchor,
      constant: Constant.ImageView.spacing.top),
     imageView.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.ImageView.spacing.trailing),
     imageView.bottomAnchor.constraint(
      equalTo: bottomAnchor,
      constant: -Constant.ImageView.spacing.bottom)]
  }
}
