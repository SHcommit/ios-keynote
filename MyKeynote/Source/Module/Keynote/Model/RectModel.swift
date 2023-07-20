//
//  RectModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

final class RectModel {
  // MARK: - Constant
  typealias AlphaConstant = AppSetting.UIConstAlpha
  
  // MARK: - Properties
  private let uniqueID: String
  
  private(set) var width: Int
  
  private var rgba: RGBAModel
  
  // MARK: - Lifecycle
  init(uniqueID: String, width: Int, rgba: RGBAModel) {
    self.uniqueID = uniqueID
    self.width = width
    self.rgba = rgba
  }
}

// MARK: - Helper
extension RectModel {
  func plusAlpha() {
    rgba.plusAlpha()
  }
  
  func minusAlpha() {
    rgba.minusAlpha()
  }
  
  var isMinusAlphaMutableState: Bool {
    let minAlpha = AlphaConstant.minAlpha
    let curAlpha = rgba.alphaValue
    
    return minAlpha != curAlpha
  }
  
  var isPlusAlphaMutableState: Bool {
    let maxAlpha = AlphaConstant.maxAlpha
    let curAlpha = rgba.alphaValue
    
    return maxAlpha != curAlpha
  }
}

// MARK: - CustomStringConvertible
extension RectModel: CustomStringConvertible {
  var description: String {
    "(\(uniqueID.description)), Side:\(width), \(rgba.description)"
  }
}
