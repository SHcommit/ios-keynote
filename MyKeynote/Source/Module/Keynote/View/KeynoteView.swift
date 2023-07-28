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
  
  private var slideMenuDetailView = SlideMenuDetailView()
  
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
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .darkGray
  }
  
  convenience init(layoutFrom superView: UIView) {
    self.init(frame: .zero)
    setLayout(from: superView)
    setupSubviewUI(with: slideMenuView, slideMenuDetailView)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
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
  func updateSlideView(with indexPath: IndexPath, rectInfo: RectModel) {
    slideMenuDetailView.configure(with: .init(rectModel: rectInfo))
  }
}

// MARK: - LayoutSupport
extension KeynoteView: LayoutSupport {
  func setConstraints() {
    _=[slideMenuViewConstraints,
       slideMenuDetailViewConstraints]
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
  
  private var slideMenuDetailViewConstraints: [NSLayoutConstraint] {
    [slideMenuDetailView.leadingAnchor.constraint(
      equalTo: slideMenuView.trailingAnchor),
     slideMenuDetailView.topAnchor.constraint(equalTo: topAnchor),
     slideMenuDetailView.trailingAnchor.constraint(equalTo: trailingAnchor),
     slideMenuDetailView.bottomAnchor.constraint(equalTo: bottomAnchor)]
  }
}
