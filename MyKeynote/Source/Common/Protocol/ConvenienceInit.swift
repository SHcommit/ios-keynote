//
//  ConvenienceInit.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import Foundation

protocol ConvenienceInit {}

extension NSObject: ConvenienceInit { }

extension ConvenienceInit where Self: AnyObject {
  @inlinable
  internal func set(_ apply: (Self) throws -> Void) rethrows -> Self {
    try apply(self)
    return self
  }
}
