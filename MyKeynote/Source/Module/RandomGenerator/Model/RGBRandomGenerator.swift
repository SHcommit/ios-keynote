//
//  RGBRandomGenerator.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

final class RGBRandomGenerator: RandomGeneratable {
  // MARK: - Constant
  typealias RandomValueType = UInt8
  
  typealias Constant = AppSetting.UIConstGScale
  
  // MARK: - Properties
  private(set) var minValue: RandomValueType = Constant.minValue
  
  private(set) var maxValue: RandomValueType = Constant.maxValue
}
