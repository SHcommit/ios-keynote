//
//  GrayscaleRange.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

@propertyWrapper
struct GrayscaleRange {
  // MARK: - Properties
  private var value: Int
  
  private let minGrayScale = Int(AppSetting.UIConstGScale.minValue)
  
  private let maxGrayScale = Int(AppSetting.UIConstGScale.maxValue)
  
  var wrappedValue: Int {
    get { value }
    set { updateValue(newValue) }
  }
  
  // MARK: - Lifecycle
  init(wrappedValue: Int) {
    value = minGrayScale
    updateValue(wrappedValue)
  }
}

// MARK: - Private helper
extension GrayscaleRange {
  private mutating func updateValue(_ newValue: Int) {
    if newValue < minGrayScale {
      value = minGrayScale
    } else if newValue > maxGrayScale {
      value = maxGrayScale
    } else {
      value = newValue
    }
  }
}
