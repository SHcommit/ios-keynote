//
//  AlphaRandomGenerator.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

final class AlphaRandomGenerator: RandomGeneratable {
  // MARK: - Constant
  typealias RandomValueType = UInt8
  
  typealias Constant = AppSetting.UIConstAlpha
  
  // MARK: - Properties
  private(set) var minValue: RandomValueType = Constant.minAlpha
  
  private(set) var maxValue: RandomValueType = Constant.maxAlpha
}
