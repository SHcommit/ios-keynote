//
//  KeynoteViewAdapterDataSource.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/27.
//

protocol KeynoteViewAdapterDataSource: AnyObject {
  var numberOfItems: Int { get }
  
  func slideDetailViewCellItem(
    at index: Int
  ) -> SlideModel
  
  func SlideMenuViewCellItem(
    at index: Int
  ) -> SlideMenuView.slideMenuViewCellTypes
}
