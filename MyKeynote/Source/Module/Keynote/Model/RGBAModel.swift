//
//  RGBAModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

struct RGBAModel {
  @GrayscaleRange var red: Int
  @GrayscaleRange var green: Int
  @GrayscaleRange var blue: Int
  var alpha: AlphaModel
}

// MARK: - Properties
extension RGBAModel {
  mutating func isValidAlphaRange(_ target: UInt8) -> Bool {
    return alpha.isValidRange(target)
  }
  
  mutating func plusAlpha() {
    alpha.upAlphaValue()
  }
  
  mutating func minusAlpha() {
    alpha.downAlphaValue()
  }
}

// MARK: - CustomStringConvertible
extension RGBAModel: CustomStringConvertible {
  var description: String {
    "R:\(red), G:\(green), B:\(blue), \(alpha.description)"
  }
}
