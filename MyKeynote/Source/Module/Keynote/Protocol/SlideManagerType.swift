//
//  SlideManagerType.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Foundation

protocol SlideManagerType {
  typealias Input = SlideManager.Input
  typealias Output = SlideManager.Output
  
  func transform(input: Input) -> Output
}
