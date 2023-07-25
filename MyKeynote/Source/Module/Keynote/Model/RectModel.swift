//
//  RectModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

final class RectModel {
  typealias RGB = RGBAModel.RGB
  // MARK: - Constant
  typealias AlphaConstant = AppSetting.UIConstAlpha
  
  // MARK: - Properties
  private let uniqueID: String
  
  private(set) var width: Int
  
  private var rgba: RGBAModel
  
  var alpha: Double {
    if rgba.isValidAlphaRange(rgba.alphaValue) {
      return Double(rgba.alphaValue)
    }
    return Double(rgba.alphaMaxValue)
  }
  
  var rgb: RGB {
    (rgba.red, rgba.green, rgba.blue)
  }
  
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
  
  func setAlpha(with value: UInt8) {
    rgba.updateAlpha(with: value)
  }
  
  func setRGB(with rgb: RGB) {
    rgba.updateColor(with: rgb)
  }
}

// MARK: - CustomStringConvertible
extension RectModel: CustomStringConvertible {
  var description: String {
    "(\(uniqueID.description)), Side:\(width), \(rgba.description)"
  }
}
