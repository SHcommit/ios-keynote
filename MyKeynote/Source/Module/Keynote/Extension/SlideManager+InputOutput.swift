//
//  SlideManager+InputOutput.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Combine

extension SlideManager {
  struct Input {
    let appear: PassthroughSubject<Void,Never>
    
    init(appear: PassthroughSubject<Void, Never> = .init()) {
      self.appear = appear
    }
  }
  
  enum State {
    case updateRectAlpha(isMinusAlphaMutableState: Bool, isPlusAlphaMutableState: Bool)
    case updateRectColor
    case none
  }
  
  typealias Output = AnyPublisher<State, Never>
}
