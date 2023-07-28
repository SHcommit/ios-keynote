//
//  SlideAccessable.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/28.
//

protocol SlideAccessable {
  func add(_ slideModel: SlideType)
  
  func update(_ slideModel: SlideType, at index: Int)
  
  func remove(at index: Int) -> SlideType?
}
