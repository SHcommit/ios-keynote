//
//  SlideModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Foundation

struct SlideModel {
  enum State {
    case rect
  }
  
  // MARK: - Properties
  var rectModel: RectModel?
  
  private(set) var state: State
  
  // MARK: - Lifecycle
  init(rectModel: RectModel? = nil, state: State) {
    self.rectModel = rectModel
    self.state = state
  }
}
