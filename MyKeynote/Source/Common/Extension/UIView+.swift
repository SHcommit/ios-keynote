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
}
