//
//  AppSetting.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/20.
//

import Foundation

struct AppSetting {
  typealias UIConstGScale = UIConstant.Grayscale
  typealias UIConstAlpha = UIConstant.Alpha
  typealias UIConstUId = UIConstant.UniqueId
  
  /// 앱에서 공동으로 사용되는 UIConstant
  enum UIConstant {
    enum Grayscale {
      static let minValue: UInt8 = 0
      static let maxValue: UInt8 = 255
    }
    
    enum Alpha {
      static let minAlpha: UInt8 = 1
      static let maxAlpha: UInt8 = 10
    }
    
    enum UniqueId {
      static let splitedWordCount: Int = 3
      static let totalStringCount: Int = 3*splitedWordCount
      static let totalWordWithSeparator = totalStringCount + 2
    }
  }
}
