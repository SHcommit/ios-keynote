//
//  AlphabetRandomGenerator.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

/// UInt32는 랜덤 함수 사용할수있어서,, 스칼라로 바꿔서 랜덤 -> 문자 로 바꿨습니다.
final class AlphabetRandomGenerator: RandomGeneratable {
  // MARK: - Constant
  typealias RandomValueType = String
  
  private typealias UnicodeScalarValueType = UInt32
  
  private static let alphabetList = "abcdefghijklmnopqrstuvwxyz"
    .map { String($0) }
  
  // MARK: - Properties
  private(set) var minValue: RandomValueType = alphabetList[0]
  
  private(set) var maxValue: RandomValueType = alphabetList
    .last!
  
  private var cachedAlphabet: [String] = []
  
  private var minScalarValue: UnicodeScalarValueType {
    minValue.unicodeScalarsFirstValue
  }
  
  private var maxScalarValue: UnicodeScalarValueType {
    maxValue.unicodeScalarsFirstValue
  }
  
  private var closedRangeScalarValue: ClosedRange<UnicodeScalarValueType> {
    minScalarValue...maxScalarValue
  }
  
  private var lowercasedRandomAlphabet: String {
    randUInt32Value.scalarValueToString
  }
  
  private var randUInt32Value: UInt32 {
    UInt32.random(in: closedRangeScalarValue)
  }
}

// MARK: - Helper
extension AlphabetRandomGenerator {
  func randValue() -> RandomValueType {
    let Lowercase = 0, Uppercase = 1
    while true {
      let alphabetCase = Int.random(in: Lowercase...Uppercase)
      let res = lowercasedRandomAlphabet
      if cachedRandomValue(res) { continue }
      if alphabetCase == Lowercase {
        return res
      } else {
        return res.uppercased()
      }
    }
  }
}

// MARK: - Private helper
extension AlphabetRandomGenerator {
  private func cachedRandomValue(_ value: String) -> Bool {
    return cachedAlphabet
      .contains(value) ? false :
    { cachedAlphabet.append(value); return true }()
  }
}
