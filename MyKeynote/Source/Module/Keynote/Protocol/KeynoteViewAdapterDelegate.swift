//
//  KeynoteViewAdapterDelegate.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/27.
//

import Foundation

protocol KeynoteViewAdapterDelegate: AnyObject {
  func updateSlideView(with indexPath: IndexPath, rectInfo: RectModel)
}
