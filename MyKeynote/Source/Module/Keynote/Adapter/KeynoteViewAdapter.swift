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

protocol KeynoteViewAdapterDelegate: AnyObject {
  func scrollToRow(with indexPath: IndexPath, rectInfo: RectModel)
}

final class KeynoteViewAdapter: NSObject {
  // MARK: - Properteis
  weak var dataSource: KeynoteViewAdapterDataSource?
  
  weak var delegate: KeynoteViewAdapterDelegate?
  
  private var prevSelectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
  
  private var isDoneInitialSetting = false
  
  // MARK: - Lifecycle
  init(
    dataSource: KeynoteViewAdapterDataSource,
    delegate: KeynoteViewAdapterDelegate,
    slideMenuViewDataSource: inout UITableViewDataSource?,
    slideMenuViewDelegate: inout UITableViewDelegate?,
    slideDetailViewDataSource: inout UITableViewDataSource?,
    slideDetailViewDelegate: inout UITableViewDelegate?
  ) {
    super.init()
    self.dataSource = dataSource
    self.delegate = delegate
    slideMenuViewDataSource = self
    slideMenuViewDelegate = self
    slideDetailViewDataSource = self
    slideDetailViewDelegate = self
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
      
      guard let item = dataSource?.slideDetailViewCellItem(at: indexPath.row) as? SlideModel else {
        return .init(style: .default, reuseIdentifier: "none")
      }
      guard let rectModel = item.getinstance as? RectModel else {
        return .init(style: .default, reuseIdentifier: "none")
      }
      
      print("index: \(indexPath.row)", rectModel.description)
      cell.configure(with: item)
      return cell
    case is SlideMenuView:
      guard
        let cell = tableView.dequeueReusableCell(
          withIdentifier: SlideMenuViewCell.id,
          for: indexPath) as? SlideMenuViewCell,
        let item = dataSource?.SlideMenuViewCellItem(at: indexPath.row),
        let image = UIImage(named: item.imageName)
      else { return .init(style: .default, reuseIdentifier: "none") }
      cell.configure(with: image, selected: false, indexText: "\(indexPath.row+1)")
      if !isDoneInitialSetting && indexPath.row == 0 {
        isDoneInitialSetting.toggle()
        cell.setImageViewBG(with: true)
      }
      
      return cell
    default:
      return .init(style: .default, reuseIdentifier: "none")
    }
  }
}

// MARK: - Private helper UITableViewDataSource
extension KeynoteViewAdapter {

}


// MARK: - UITableViewDelegate
extension KeynoteViewAdapter: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch tableView {
    case is SlideDetailView:
      print("DEBUG: Is slideDetailView tapped?")
    case is SlideMenuView:
      break
    default: break
    }
    
    switch tableView {
    case is SlideDetailView:
      break
    case is SlideMenuView:
      guard let slideMenuView = tableView as? SlideMenuView else {
        break
      }
      guard
        let prevCell = slideMenuView.cellForRow(at: prevSelectedIndexPath) as? SlideMenuViewCell,
        let curCell = slideMenuView.cellForRow(at: indexPath) as? SlideMenuViewCell,
        let rectInfo = dataSource?.slideDetailViewCellItem(at: indexPath.row).getinstance as? RectModel
      else {
        break
      }
      prevCell.setImageViewBG(with: false)
      curCell.setImageViewBG(with: true)
      delegate?.scrollToRow(with: indexPath,rectInfo: rectInfo)
    default:
      break
    }
    prevSelectedIndexPath = indexPath
    
    //이게 만들어져야.. 좋은데,,
    guard let detailView = tableView as? SlideDetailView else {
      return
    }
  }
}
