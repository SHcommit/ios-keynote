//
//  SlideViewAbstractFactory.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

import UIKit

protocol SlideViewAbstractFactory {
  func makeSlideView() -> UIView
  func makeRectView() -> UIView
}

extension SlideViewAbstractFactory {
  func makeRectView() -> UIView { return .init() }
}
