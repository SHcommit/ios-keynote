//
//  NumberRandomGenerator.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

final class NumberRandomGenerator: RandomGeneratable {
  // MARK: - Constant
  typealias RandomValueType = UInt32
  
  // MARK: - Properties
  private(set) var minValue: RandomValueType = 0
  
  private(set) var maxValue: RandomValueType = 9
  
  private var cachedNumber: [RandomValueType] = []
  
  private var closedRangeScalarValue: ClosedRange<RandomValueType> {
    minValue...maxValue
  }
  
  private var randInt32Value: RandomValueType {
    UInt32.random(in: closedRangeScalarValue)
  }
}

// MARK: - Helper
extension NumberRandomGenerator {
  func randValue() -> RandomValueType {
    while true {
      let res = randInt32Value
      if cachedRandomValue(res) { continue }
      return res
    }
  }
}

// MARK: - Private helper
extension NumberRandomGenerator {
  private func cachedRandomValue(_ value: RandomValueType) -> Bool {
    return cachedNumber
      .contains(value) ? false :
    { cachedNumber.append(value); return true }()
  }
}
