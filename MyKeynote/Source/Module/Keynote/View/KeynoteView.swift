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
  
  // MARK: - Properties
  private let slideMenuView = SlideMenuView()
  
  private lazy var slideDetailView = SlideDetailView()
  
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
  
  var slideDataViewDelegate: UITableViewDelegate? {
    get {
      slideDetailView.delegate
    } set {
      slideDetailView.delegate = newValue
    }
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviewUI(with: slideMenuView, slideDetailView)
    backgroundColor = .darkGray 
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
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
      equalTo: safeAreaLayoutGuide.topAnchor),
     slideMenuView.bottomAnchor.constraint(
      equalTo: bottomAnchor),
     slideMenuView.widthAnchor.constraint(
      equalToConstant: Constant.SlideMenuView.width)]
  }
  
  private var slideDetailViewConstraints: [NSLayoutConstraint] {
    [slideDetailView.leadingAnchor.constraint(
      equalTo: slideMenuView.trailingAnchor),
     slideDetailView.topAnchor.constraint(
      equalTo: safeAreaLayoutGuide.topAnchor),
     slideDetailView.trailingAnchor.constraint(
      equalTo: trailingAnchor),
     slideDetailView.bottomAnchor.constraint(
      equalTo: bottomAnchor)]
  }
}
