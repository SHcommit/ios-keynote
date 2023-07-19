//
//  UniqueIdRandomGenerator.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

final class UniqueIDRandomGenerator: RandomGeneratable {
  // MARK: - Constant
  typealias RandomValueType = String
  
  // MARK: - Properties
  private(set) var minValue:  RandomValueType = "0"
  private(set) var maxValue: RandomValueType = "z"
}

// MARK: - Helper
extension UniqueIDRandomGenerator {
  func randValue() -> RandomValueType   {
    let alphaBetRandomGenerator = AlphabetRandomGenerator()
    let numberRandomGenerator = NumberRandomGenerator()
    let randomValues = combineRandomValues(
      alphabetRandomGenerator: alphaBetRandomGenerator, numberRandomGenerator:
        numberRandomGenerator)
    return (0..<9).map {
      if ($0+1) % 3 == 0 && $0 < 8 {
        return "\(randomValues[$0])-"
      }else {
        return randomValues[$0]
      }
    }.joined(separator: "")
  }
}

// MARK: - Private helper
extension UniqueIDRandomGenerator {
  private func combineRandomValues(
    alphabetRandomGenerator: some RandomGeneratable,
    numberRandomGenerator: some RandomGeneratable
  ) -> [String]  {
    let AlphabetCase = 0, AlphaCase = 1
    
    return (0..<9)
      .map {_ in
        let randomCase = Int.random(in: AlphabetCase...AlphaCase)
        if randomCase == AlphaCase {
          return "\(numberRandomGenerator.randValue())"
        } else {
          return "\(alphabetRandomGenerator.randValue())"
        }
      }
  }
}
