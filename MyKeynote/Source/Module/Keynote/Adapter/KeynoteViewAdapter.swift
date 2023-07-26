//
//  KeynoteViewAdapter.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/26.
//

import UIKit

protocol KeynoteViewAdapterDataSource: AnyObject {
  var numberOfItems: Int { get }
  
  func slideDetailViewCellItem(
    at index: Int
  ) -> SlideModel
  
  func SlideMenuViewCellItem(
    at index: Int
  ) -> SlideMenuView.slideMenuViewCellTypes
}

protocol SlideDetailViewDelegate: AnyObject { }

final class KeynoteViewAdapter: NSObject {
  // MARK: - Properteis
  weak var dataSource: KeynoteViewAdapterDataSource?
  
  // MARK: - Lifecycle
  init(
    dataSource: KeynoteViewAdapterDataSource,
    slideMenuViewDataSource: inout UITableViewDataSource?,
    slideMenuViewDelegate: inout UITableViewDelegate?,
    slideDetailViewDataSource: inout UITableViewDataSource?,
    slideDetailViewDelegate: inout UITableViewDelegate?
  ) {
    super.init()
    self.dataSource = dataSource
    slideMenuViewDataSource = self
    slideMenuViewDelegate = self
    slideDetailViewDataSource = self
    slideDetailViewDelegate = self
//    completionHandler()
  }
}

// MARK: - UITableViewDataSource
extension KeynoteViewAdapter: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource?.numberOfItems ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableView {
    case is SlideDetailView:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: SlideDetailViewCell.id,
        for: indexPath) as? SlideDetailViewCell
      else { return .init(style: .default, reuseIdentifier: SlideMenuViewCell.id) }
      guard let item = dataSource?.slideDetailViewCellItem(at: indexPath.row) else {
        return .init(style: .default, reuseIdentifier: "none")
      }
      cell.configure(with: item)
      return cell
    case is SlideMenuView:
      return .init()
    default:
      return .init(style: .default, reuseIdentifier: "none")
    }
  }
}

extension KeynoteViewAdapter: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// 여기서 해야할 것은 메뉴뷰 터치되면 디테일 뷰 위치 동기화 !!
    switch tableView {
    case is SlideDetailView:
      break
    case is SlideMenuView:
      break
    default:
      break
    }
  }
}
