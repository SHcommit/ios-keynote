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
  
  private let inspectorView = InspectorView()
  
  private let slideContentView = SlideContentView()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviewUI(with: slideMenuView, inspectorView, slideContentView)
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
       inspectorViewConstraints,
       slideContentViewConstraints]
      .map {
        NSLayoutConstraint.activate($0)
        print(Constant.SlideMenuView.width)
      }
  }
  
  private var slideMenuViewConstraints: [NSLayoutConstraint] {
    [slideMenuView.leadingAnchor.constraint(equalTo: leadingAnchor),
     slideMenuView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
     slideMenuView.bottomAnchor.constraint(equalTo: bottomAnchor),
     slideMenuView.widthAnchor.constraint(equalToConstant: Constant.SlideMenuView.width)]
  }
  
  private var inspectorViewConstraints: [NSLayoutConstraint] {
    [inspectorView.trailingAnchor.constraint(equalTo: trailingAnchor),
     inspectorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
     inspectorView.bottomAnchor.constraint(equalTo: bottomAnchor),
     inspectorView.widthAnchor.constraint(equalToConstant: Constant.InspectorView.width)]
  }
  
  private var slideContentViewConstraints: [NSLayoutConstraint] {
    [slideContentView.leadingAnchor.constraint(equalTo: slideMenuView.trailingAnchor),
     slideContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
     slideContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
     slideContentView.trailingAnchor.constraint(equalTo: inspectorView.leadingAnchor)]
  }
}
