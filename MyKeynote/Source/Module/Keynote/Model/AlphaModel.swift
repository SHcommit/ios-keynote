//
//  AlphaModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

struct AlphaModel {
  // MARK: - Constant
  private let minValue: UInt8 = 1
  private let maxValue: UInt8 = 10
  private lazy var availableRange: ClosedRange = minValue...maxValue
  
  // MARK: - Properties
  private var alpha: UInt8
  
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
  
  mutating func upAlphaValue() {
    if isValidRange(alpha+1) { alpha += 1 }
  }
  
  mutating func downAlphaValue() {
    if isValidRange(alpha-1) { alpha -= 1 }
  }
}
