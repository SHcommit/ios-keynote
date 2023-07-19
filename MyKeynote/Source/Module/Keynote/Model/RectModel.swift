//
//  RectModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

final class RectModel {
  // MARK: - Properties
  private let uniqueID: String
  private let width: Int
  private var rgba: RGBAModel
  
  // MARK: - Lifecycle
  init(uniqueID: String, width: Int, rgba: RGBAModel) {
    self.uniqueID = uniqueID
    self.width = width
    self.rgba = rgba
  }
}

extension RectModel {
  func plusAlpha() {
    rgba.alpha.plusAlpha()
  }
  
  func minusAlpha() {
    rgba.alpha.minusAlpha()
  }
  
  var isAlphaMutableState: Bool {
    rgba
  }
}
