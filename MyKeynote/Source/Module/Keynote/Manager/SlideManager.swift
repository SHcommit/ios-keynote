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
      let alphaValue = userInfo[userInfoKey] as? Int
    else {
      return
    }
    alphaValueSubject.send(alphaValue)
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
    return Publishers
      .MergeMany([
        changedStepperValueChains(),
        appearChains(with: input)])
      .eraseToAnyPublisher()
  }
}

// MARK: - Private helper
private extension SlideManager {
  func changedStepperValueChains() -> Output {
    return alphaValueSubject
      .subscribe(on: RunLoop.main)
      .map { alpha -> State in
        let alphaMaxValue = Double(AppSetting.UIConstAlpha.maxAlpha)
        return .updateRectAlpha(Double(alpha)/alphaMaxValue)
      }.eraseToAnyPublisher()
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
  
  func cellItem(at index: Int) -> SlideModel {
    return slideModels[index]
  }
}
