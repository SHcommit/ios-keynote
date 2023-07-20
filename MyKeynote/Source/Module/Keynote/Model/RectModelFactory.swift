//
//  RectModelFactory.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

import Foundation

final class RectModelFactory: RectModelAbstractFactory {
  // MARK: - Properties
  private let uniqueIdRGenerator = UniqueIDRandomGenerator()
  
  private let alphaRGenerator = AlphaRandomGenerator()
  
  private let rgbRGenerator = RGBRandomGenerator()
}

// MARK: - Helper
extension RectModelFactory {
  func makeUniqueIdRandomValue() -> String {
    return uniqueIdRGenerator.randValue()
  }
  
  func makeAlphaRandomValue() -> UInt8 {
    return alphaRGenerator.randValue()
  }
  
  func makeRGBRandomValue() -> (R: UInt8, G: UInt8, B: UInt8) {
    let rgb = (0..<3).map { _ in return  rgbRGenerator.randValue() }
    return (rgb[0], rgb[1], rgb[2])
  }
}
