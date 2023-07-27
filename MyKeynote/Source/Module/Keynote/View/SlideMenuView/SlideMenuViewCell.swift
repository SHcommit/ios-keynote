//
//  SlideMenuViewCell.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/25.
//

import UIKit

final class SlideMenuViewCell: UITableViewCell {
  // MARK: - Constant
  static let id = String(describing: SlideMenuViewCell.self)
  
  struct Constant {
    static let intrinsicContentSize: CGSize = {
      let width = KeynoteView.Constant.SlideMenuView.width
      let height = width/5*3
      return .init(width: width, height:  height)
    }()
    
    enum SlideThumbnail {
      static let size: CGSize = {
        let width: CGFloat = Constant.intrinsicContentSize.width / 4 * 3
        let height: CGFloat = width * 3 / 4
        return .init(width: width, height: height)
      }()
    }
    
    enum IndexLabel {
      static let textSize: CGFloat = 15
    }
  }
   
  // MARK: - UIProperties
  private let slideThumbnail = SlideThumbnailView()
  
  private let indexLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: Constant.IndexLabel.textSize, weight: .semibold)
    $0.text = "_"
    $0.sizeToFit()
  }
  
  // MARK: - Lifecycle
  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviewUI(with: slideThumbnail, indexLabel)
    selectionStyle = .none
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - Helper
extension SlideMenuViewCell {
  func configure(with: UIImage, selected: Bool, indexText: String) {
    slideThumbnail.configure(with: with, selected: selected)
    setIndexLabel(with: indexText)
  }
  
  func setImageViewBG(with: Bool) {
    slideThumbnail.setImageViewBG(with: with)
  }
  
  // MARK: - Private helper
  private func setIndexLabel(with text: String) {
    DispatchQueue.main.async {
      self.indexLabel.text = text
    }
  }
}

// MARK: - LayoutSupport
extension SlideMenuViewCell: LayoutSupport {
  func setConstraints() {
    _=[slideThumbnailConstraints, indexLabelConstraints].map { NSLayoutConstraint.activate($0) }
  }
}

// MARK: - Private LayoutSupport
private extension SlideMenuViewCell {
  var slideThumbnailConstraints: [NSLayoutConstraint] {
    [slideThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
     slideThumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
     slideThumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
     slideThumbnail.widthAnchor.constraint(
      equalToConstant: Constant.SlideThumbnail.size.width)]
  }
  
  var indexLabelConstraints: [NSLayoutConstraint] {
    [indexLabel.trailingAnchor.constraint(equalTo: slideThumbnail.leadingAnchor),
     indexLabel.bottomAnchor.constraint(equalTo: slideThumbnail.bottomAnchor)]
  }
}
