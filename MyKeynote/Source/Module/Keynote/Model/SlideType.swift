//
//  SlideModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Foundation

/*
 헉... 대박.. 얕은복사....... RectModel은 클래스타입으로 했는데,
 SlideModel은 struct로했고,, SlideManager's KeynoteViewAdapterDataSource로 특정 SlideModel을 반환할 때,,,
 얕은 복사가 되는 것으로 추정.. 그래서 rectModel의 특정 set함수로 데이터를 바꿔도 반영이 안되는 거였다..
 */
class SlideType {
  enum State {
    case rect (RectModel)
    case image(String)
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
    case .image(let imageStr):
      return imageStr
    }
  }
}
