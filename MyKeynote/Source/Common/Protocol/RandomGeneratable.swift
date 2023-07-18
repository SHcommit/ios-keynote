//
//  RandomGeneratable.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

protocol RandomGeneratable {
  associatedtype RandomValue
  
  func randAValue() -> RandomValue
  func randValues() -> [RandomValue]
}

extension RandomGeneratable {
  /// 이 프로토콜을 준수한 후 여러 randValues를 반환해야한다면 이 메서드를 선언하세요!!
  func randValues() -> [RandomValue] { return [] }
}
