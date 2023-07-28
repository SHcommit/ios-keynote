//
//  SlideRectModelAccessable.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/28.
//

protocol SlideRectModelAccessable {
  func searchRectModel(with uniqueId: String) -> RectModel?
  
  func findRectModelIndex(with uniqueId: String) -> Int?
}
