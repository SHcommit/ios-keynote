//
//  KeynoteSlideMenuDataSource.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

protocol KeynoteSlideMenuDataSource {
  var numberOfItems: Int { get }
  func cellItem(at index: Int) -> SlideModel
}
