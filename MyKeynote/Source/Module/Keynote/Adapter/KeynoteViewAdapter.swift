//
//  KeynoteViewAdapter.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/26.
//

import UIKit

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
    slideMenuViewDelegate: inout UITableViewDelegate?
  ) {
    super.init()
    self.dataSource = dataSource
    self.delegate = delegate
    slideMenuViewDataSource = self
    slideMenuViewDelegate = self
  }
}

// MARK: - UITableViewDataSource
extension KeynoteViewAdapter: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource?.numberOfItems ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: SlideMenuViewCell.id,
        for: indexPath) as? SlideMenuViewCell,
      let item = dataSource?.SlideMenuViewCellItem(at: indexPath.row),
      let image = UIImage(named: item.imageName)
    else { return .init(style: .default, reuseIdentifier: "none") }
    
    cell.configure(with: image, selected: false, indexText: "\(indexPath.row+1)")
    
    if isDoneInitialSettingInSlideMenuView(indexPath.row) {
      setInitialSettingInSlideMenuView(cell)
    }
    return cell
    
  }
}

// MARK: - Private helper UITableViewDataSource
private extension KeynoteViewAdapter {
  func isDoneInitialSettingInSlideMenuView(_ index: Int) -> Bool {
    return !isDoneInitialSetting && index == 0
  }
  
  func setInitialSettingInSlideMenuView(_ cell: SlideMenuViewCell) {
      isDoneInitialSetting.toggle()
      cell.setImageViewBG(with: true)
      guard let detailItem = dataSource?
        .slideDetailViewCellItem(at: 0)
      else {
        return
      }
    switch detailItem.state {
    case .rect(let rectMdoel):
      delegate?.updateSlideView(with:.init(row: 0, section: 0) , rectInfo: rectMdoel)
    case .image(_):
      break
    }
  }
}

// MARK: - UITableViewDelegate
extension KeynoteViewAdapter: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    guard
      let slideMenuView = tableView as? SlideMenuView,
      let prevCell = slideMenuView.cellForRow(at: prevSelectedIndexPath) as? SlideMenuViewCell,
      let curCell = slideMenuView.cellForRow(at: indexPath) as? SlideMenuViewCell,
      let rectInfo = dataSource?
        .slideDetailViewCellItem(at: indexPath.row)
    else {
      return
    }
    prevCell.setImageViewBG(with: false)
    switch rectInfo.state {
    case .rect(let rectModel):
      delegate?.updateSlideView(with: indexPath, rectInfo: rectModel)
    case .image(_):
      // TODO: - 이미지 cell을 추가한다면, delegate로 전달.
      break
    }
    
    // TODO: - prevSelectedIdx, curSelectedIdx같으면 슬라이드 내용 히든, curCell selected state cancel 해야 함.
    prevSelectedIndexPath = indexPath
    curCell.setImageViewBG(with: true)
  }
}
