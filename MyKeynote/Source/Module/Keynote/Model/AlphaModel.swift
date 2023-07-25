//
//  AlphaModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

struct AlphaModel {
  // MARK: - Constant
  private(set) var minValue: UInt8 = AppSetting.UIConstAlpha.minAlpha
  private(set) var maxValue: UInt8 = AppSetting.UIConstAlpha.maxAlpha
  private lazy var availableRange: ClosedRange = minValue...maxValue
  
  // MARK: - Properties
  private(set) var alpha: UInt8
  
  // MARK: - Lifecycle
  init(alpha: UInt8) {
    self.alpha = alpha
  }
}

// MARK: - Helper
extension AlphaModel {
  mutating func isValidRange(_ target: UInt8) -> Bool {
    return availableRange.contains(target)
  }
  
  mutating func plusAlpha() {
    if isValidRange(alpha+1) { alpha += 1 }
  }
  
  mutating func minusAlpha() {
    if isValidRange(alpha-1) { alpha -= 1 }
  }
}

// MARK: - CustomStringConvertible
extension AlphaModel: CustomStringConvertible {
  var description: String {
    "Alpha: \(alpha)"
  }
}
