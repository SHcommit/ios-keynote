//
//  AlphaRandomGenerator.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

final class AlphaRandomGenerator: RandomGeneratable {
  // MARK: - Constant
  typealias RandomValueType = UInt8
  
  // MARK: - Properties
  private(set) var minValue: RandomValueType = 0
  private(set) var maxValue: RandomValueType = 10
}
