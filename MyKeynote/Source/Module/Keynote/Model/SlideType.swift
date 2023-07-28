//
//  SlideModel.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Foundation

struct SlideType {
  enum State {
    case rect(RectModel)
    case image(String)
     
    func isEqual(uniqueId: String) -> Bool {
      switch self {
      case .rect(let rectModel):
        return rectModel.uniqueID == uniqueId
      default: return false
      }
    }
    
    var getRectModel: RectModel? {
      switch self {
      case .rect(let rectModel):
        return rectModel
      default: return nil
      }
    }
    
    var getImageUrl: String? {
      switch self{
      case .image(let imageUrl):
        return imageUrl
      default: return nil
      }
    }
  }
  
  // MARK: - Properties
  private(set) var state: State
  
  
  // MARK: - Lifecycle
  init(rectModel: RectModel) {
    self.state = .rect(rectModel)
  }
  
  init(imageName: String) {
    self.state = .image(imageName)
  }
}
