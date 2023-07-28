//
//  RGBAModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

class RGBAModel {
  typealias RGB = (R: UInt8, G: UInt8, B: UInt8)
  // MARK: - Properties
  @GrayscaleRange private(set) var red: UInt8
  
  @GrayscaleRange private(set) var green: UInt8
  
  @GrayscaleRange private(set) var blue: UInt8
  
  private var alpha: AlphaModel
  
  var alphaMaxValue: UInt8 {
    alpha.maxValue
  }
  
  var alphaMinValue: UInt8 {
    alpha.minValue
  }
  
  // MARK: - Lifecycle
  init(
    red: UInt8,
    green: UInt8,
    blue: UInt8,
    alpha: AlphaModel
  ) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
}

// MARK: - Helper
extension RGBAModel {
  func isValidAlphaRange(_ target: UInt8) -> Bool {
    return alpha.isValidRange(target)
  }
  
  func updateAlpha(with alphaValue: UInt8) {
    alpha.setAlpha(with: alphaValue)
  }
  
  var alphaValue: UInt8 {
    alpha.alpha
  }
  
  func updateColor(with rgb: RGB) {
    red = rgb.R
    green = rgb.G
    blue = rgb.B
  }
}

// MARK: - CustomStringConvertible
extension RGBAModel: CustomStringConvertible {
  var description: String {
    "R:\(red), G:\(green), B:\(blue), \(alpha.description)"
  }
}
