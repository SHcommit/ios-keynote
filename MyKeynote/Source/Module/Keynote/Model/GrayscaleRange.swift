//
//  GrayscaleRange.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

import Foundation

@propertyWrapper
struct GrayscaleRange {
  private var value: Int
  var wrappedValue: Int {
    get { value }
    set { updateValue(newValue) }
  }
  
  init(wrappedValue: Int) {
    value = 0
    updateValue(wrappedValue)
  }
}

// MARK: - Private helper
extension GrayscaleRange {
  private mutating func updateValue(_ newValue: Int) {
    if newValue < 0 {
      value = 0
    } else if newValue > 255 {
      value = 255
    } else {
      value = newValue
    }
  }
}
