//
//  SlideModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Foundation

struct SlideModel {
  enum State {
    case rect (RectModel)
    case image(AlphaView)
  }
  
  // MARK: - Properties
  private(set) var state: State
  
  
  // MARK: - Lifecycle
  init(state: State) {
    self.state = state
  }
  
  var getinstance: Any? {
    switch state {
    case .rect(let rectModel):
      return rectModel
    default:
      return nil
    }
  }
}
