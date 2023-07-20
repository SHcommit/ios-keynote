//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import Foundation
import Combine


final class SlideManager {
  // MARK: - Properties
  private let rectModelFactory: RectModelAbstractFactory
  
  private let uniqueIdStorage = UniqueIdRandomGeneratorStorage
    .shared
  
  private var slideModels: [SlideModel] = []
  
  // MARK: - Lifecycle
  init(rectModelFactory: RectModelAbstractFactory) {
    self.rectModelFactory = rectModelFactory
  }
}

// MARK: - Private helper
private extension SlideManager {
  func makeRectModel() -> RectModel {
    let uniqueId = uniqueIdStorage.create(
      from: rectModelFactory)
    let rgb = rectModelFactory.makeRGBRandomValue()
    let alpha = rectModelFactory.makeAlphaRandomValue()
    
    let alphaModel = AlphaModel(alpha: alpha)
    
    let rgbaModel = RGBAModel(
      red: rgb.R,
      green: rgb.G,
      blue: rgb.B,
      alpha: alphaModel)
    
    return RectModel(
      uniqueID: uniqueId,
      width: Int.random(in: 100...400),
      rgba: rgbaModel)
  }
}

// MARK: - SlideManagerType
extension SlideManager: SlideManagerType {
  func transform(input: Input) -> Output {
    return input.appear.map {_ -> State in return .none }.eraseToAnyPublisher()
  }
}

// MARK: - KeynoteSlideMenuDataSource
extension SlideManager: KeynoteSlideMenuDataSource  {
  var numberOfItems: Int {
    slideModels.count
  }
  
  func cellItem(at index: Int) -> SlideModel {
    return slideModels[index]
  }
}
