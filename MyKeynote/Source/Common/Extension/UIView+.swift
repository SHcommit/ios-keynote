//
//  UIView+.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: [UIView]) {
    _=subviews.map { addSubview($0) }
  }
  
  static var statusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
      guard
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let window = windowScene.windows.first
      else {
        return 0.0
      }
      return window.safeAreaInsets.top
    } else {
      return UIApplication.shared.statusBarFrame.size.height
    }
  }
}
