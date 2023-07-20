//
//  UInt32+.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

import Foundation

extension UInt32 {
  var scalarValueToString: String {
    guard let unicodeScalar = UnicodeScalar(self) else { return "" }
    return String(Character(unicodeScalar))
  }
}
