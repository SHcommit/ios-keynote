//
//  KeynoteViewController+3-1Mission.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/26.
//

import Foundation

extension KeynoteViewController {
  func missionWeek3_1() {
    let rectModelFactory = RectModelFactory()
    let uniqueIdStorage = UniqueIdRandomGeneratorStorage
      .shared
    
    let rectModelDescriptions = (0..<4).map {
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
      let rectModel = RectModel(
        uniqueID: uniqueId,
        width: Int.random(in: 100...400),
        rgba: rgbaModel)
      return "Rect\($0+1) " + rectModel.description
    }
  }
}
