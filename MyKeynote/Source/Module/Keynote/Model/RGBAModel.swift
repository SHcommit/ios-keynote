//
//  RGBAModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

struct RGBAModel {
  @GrayscaleRange var red: UInt8
  @GrayscaleRange var green: UInt8
  @GrayscaleRange var blue: UInt8
  private var alpha: AlphaModel
  
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
  mutating func isValidAlphaRange(_ target: UInt8) -> Bool {
    return alpha.isValidRange(target)
  }
  
  mutating func plusAlpha() {
    alpha.plusAlpha()
  }
  
  mutating func minusAlpha() {
    alpha.minusAlpha()
  }
  
  var alphaValue: UInt8 {
    alpha.alpha
  }
}

// MARK: - CustomStringConvertible
extension RGBAModel: CustomStringConvertible {
  var description: String {
    "R:\(red), G:\(green), B:\(blue), \(alpha.description)"
  }
}
