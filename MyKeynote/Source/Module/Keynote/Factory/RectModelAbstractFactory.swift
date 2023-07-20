//
//  RectModelAbstractFactory.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

protocol RectModelAbstractFactory {
  func makeUniqueIdRandomValue() -> String
  func makeAlphaRandomValue() -> UInt8
  func makeRGBRandomValue() -> (R: UInt8, G: UInt8, B: UInt8)
}
