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
  
  private var slideModels: [SlideType] = []
  
  private var alphaValueSubject = PassthroughSubject<Int, Never>()
  
  private var subscription = Set<AnyCancellable>()
  
  // MARK: - Lifecycle
  init(rectModelFactory: RectModelAbstractFactory) {
    self.rectModelFactory = rectModelFactory
    bind()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(
      self,
      name: .AlphaViewStepperValueChanged,
      object: nil)
  }
}

// MARK: - @Objc Helper
extension SlideManager {
  @objc func setBgStateView(_ notification: Notification) {
    let userInfoKey = AlphaView.Constant.Stepper.notificatonCenterPostKey
    guard
      let userInfo = notification.userInfo,
      let (alpha, uniqueId) = userInfo[userInfoKey] as? (alpha: Int, uniqueId: String),
      let rectModel = searchRectModel(with: uniqueId),
      let rectModelIdx = findRectModelIndex(with: uniqueId)
    else {
      print("nonononono T_T")
      return
    }
    rectModel.setAlpha(with: UInt8(alpha))
    update(.init(rectModel: rectModel), at: rectModelIdx)
  }
}


// MARK: - Helper
extension SlideManager {
  func makeRectModel() -> RectModel {
    let uniqueId = uniqueIdStorage.create(
      from: rectModelFactory)
    let rgb = rectModelFactory.makeRGBRandomValue()
    let alpha: UInt8 = 10
    
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
    return Publishers
      .MergeMany([
        appearChains(with: input)])
      .eraseToAnyPublisher()
  }
}

// MARK: - Private helper
private extension SlideManager {
  func bind() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(setBgStateView),
      name: .AlphaViewStepperValueChanged,
      object: nil)
  }
  
  func appearChains(with input: Input) -> Output {
    return input.appear
      .map { return .none }
      .eraseToAnyPublisher()
  }
}

// MARK: - KeynoteSlideMenuDataSource
extension SlideManager: KeynoteSlideMenuDataSource  {
  var numberOfItems: Int {
    slideModels.count
  }
  
  func cellItem(at index: Int) -> SlideType {
    return slideModels[index]
  }
}

// MARK: - KeynoteViewAdapterDataSource
extension SlideManager: KeynoteViewAdapterDataSource {
  func slideDetailViewCellItem(at index: Int) -> SlideType {
    return slideModels[index]
  }
  
  func SlideMenuViewCellItem(
    at index: Int
  ) -> SlideMenuView.slideMenuViewCellTypes {
    switch slideModels[index].state {
    case .image(_): return .image
    case .rect(_): return .rect
    }
  }
}

// MARK: - SlideModelAccessable
extension SlideManager: SlideAccessable {
  func remove(at index: Int) -> SlideType? {
    return slideModels.remove(at: index)
  }
  
  func add(_ slideModel: SlideType) {
    slideModels.append(slideModel)
  }
  
  func update(_ slideModel: SlideType, at index: Int) {
    slideModels[index] = slideModel
  }
}

// MARK: - SlideRectModelAccessable
extension SlideManager: SlideRectModelAccessable {
  func searchRectModel(with uniqueId: String) -> RectModel? {
    return slideModels
      .first(where: {
        guard let rectModel = $0.state.getRectModel else {
          return false
        }
        return rectModel.uniqueID == uniqueId
      })
      .flatMap { $0.state.getRectModel }
  }
    
  func findRectModelIndex(with uniqueId: String) -> Int? {
    return slideModels
      .firstIndex(where: {
        guard let rectModel = $0.state.getRectModel else {
          return false
        }
        return rectModel.uniqueID == uniqueId
      })
  }
}
