//
//  KeynoteView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

final class KeynoteView: UIView {
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    backgroundColor = .systemPink.withAlphaComponent(1)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
