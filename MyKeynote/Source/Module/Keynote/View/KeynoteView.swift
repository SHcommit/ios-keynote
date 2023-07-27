//
//  KeynoteView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

final class KeynoteView: UIView {
  // MARK: - Constant
  struct Constant {
    enum SlideMenuView {
      static let width = {
        let screenBounds = UIScreen.main.bounds
        return (screenBounds.width - screenBounds.height) / 2.3
      }()
    }
    enum ContentView {
      static let heightRatio = 0.75
    }
    
    enum InspectorView {
      static let width = SlideMenuView.width
    }
  }
  
  // MARK: - UI Properties
  private let slideMenuView = SlideMenuView()
  
  private var slideDetailView = SlideDetailView()
  
  // MARK: - Properties
  var slideMenuViewDataSource: UITableViewDataSource? {
    get {
      slideMenuView.dataSource
    } set {
      slideMenuView.dataSource = newValue
    }
  }
  
  var slideMenuViewDelegate: UITableViewDelegate? {
    get {
      slideMenuView.delegate
    } set {
      slideMenuView.delegate = newValue
    }
  }
  
  var slideDatailViewDataSource: UITableViewDataSource? {
    get {
      slideDetailView.dataSource
    } set {
      slideDetailView.dataSource = newValue
    }
  }
  
  var slideDetailViewDelegate: UITableViewDelegate? {
    get {
      slideDetailView.delegate
    } set {
      slideDetailView.delegate = newValue
    }
  }
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .darkGray
  }
  
  convenience init(layoutFrom superView: UIView) {
    self.init(frame: .zero)
    setLayout(from: superView)
    layoutIfNeeded()
    setupSubviewUI(with: slideMenuView, slideDetailView)
    slideDetailView.rowHeight = bounds.height - UIView.statusBarHeight*2
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - Helper
extension KeynoteView {
  func setInitialTableViews() {
    let indexPath = IndexPath(row: 0, section: 0)
    guard let cell = slideMenuView.cellForRow(at: indexPath) as? SlideMenuViewCell else {
      return
    }
    cell.setImageViewBG(with: true)
    slideMenuView.reloadRows(at: [indexPath], with: .automatic)
  }
}

// MARK: - Private helper
private extension KeynoteView {
  func setLayout(from superView: UIView) {
    superView.addSubview(self)
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor),
      bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)])
  }
}

// MARK: - KeynoteViewAdapterDelegate
extension KeynoteView: KeynoteViewAdapterDelegate {
  func scrollToRow(with indexPath: IndexPath, rectInfo: RectModel) {
    guard
      let cell = slideDetailView.cellForRow(at: indexPath) as? SlideDetailViewCell
    else { return }
    cell.prepareForReuse()
    cell.configure(with: .init(state: .rect(rectInfo)))
    slideDetailView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
  }
}

// MARK: - LayoutSupport
extension KeynoteView: LayoutSupport {
  func setConstraints() {
    _=[slideMenuViewConstraints,
       slideDetailViewConstraints]
      .map {
        NSLayoutConstraint.activate($0)
      }
  }
  
  private var slideMenuViewConstraints: [NSLayoutConstraint] {
    [slideMenuView.leadingAnchor.constraint(
      equalTo: leadingAnchor),
     slideMenuView.topAnchor.constraint(
      equalTo: topAnchor),
     slideMenuView.bottomAnchor.constraint(
      equalTo: bottomAnchor),
     slideMenuView.widthAnchor.constraint(
      equalToConstant: Constant.SlideMenuView.width)]
  }
  
  private var slideDetailViewConstraints: [NSLayoutConstraint] {
    [slideDetailView.leadingAnchor.constraint(
      equalTo: slideMenuView.trailingAnchor),
     slideDetailView.topAnchor.constraint(
      equalTo: topAnchor),
     slideDetailView.trailingAnchor.constraint(
      equalTo: trailingAnchor),
     slideDetailView.bottomAnchor.constraint(
      equalTo: bottomAnchor)]
  }
}
