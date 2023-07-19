//
//  UnicodeScalars+.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//


extension String {
  var unicodeScalarsFirstValue: UInt32 {
    guard let first = unicodeScalars.first else {
      return 0
    }
    return first.value
  }
}
