//
//  RandomGeneratable.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

protocol RandomGeneratable {
  associatedtype RandomValueType
  
  var minValue: RandomValueType { get }
  var maxValue: RandomValueType { get }
  
  func randValue() -> RandomValueType
}

/// When RandomValue type conform unsigned integer type : )
extension RandomGeneratable
where
  RandomValueType: FixedWidthInteger,
  RandomValueType: UnsignedInteger
{
  func randValue() -> RandomValueType {
    let range = minValue...maxValue
    return RandomValueType.random(in: range)
  }
  
  func randValues(with cnt: Int) -> [RandomValueType] {
    return (0..<cnt).map { _ in return randValue() }
  }
}
