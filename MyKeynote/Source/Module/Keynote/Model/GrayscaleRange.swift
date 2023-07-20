//
//  GrayscaleRange.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

@propertyWrapper
struct GrayscaleRange {
  // MARK: - Properties
  private var value: UInt8
  
  private let minGrayScale = AppSetting.UIConstGScale.minValue
  
  private let maxGrayScale = AppSetting.UIConstGScale.maxValue
  
  var wrappedValue: UInt8 {
    get { value }
    set { updateValue(newValue) }
  }
  
  // MARK: - Lifecycle
  init(wrappedValue: UInt8) {
    value = minGrayScale
    updateValue(wrappedValue)
  }
}

// MARK: - Private helper
extension GrayscaleRange {
  private mutating func updateValue(_ newValue: UInt8) {
    if newValue < minGrayScale {
      value = minGrayScale
    } else if newValue > maxGrayScale {
      value = maxGrayScale
    } else {
      value = newValue
    }
  }
}
