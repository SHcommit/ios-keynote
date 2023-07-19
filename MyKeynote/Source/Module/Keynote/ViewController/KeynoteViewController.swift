//
//  KeynoteViewController.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

class KeynoteViewController: UIViewController {
  // MARK: - Properties
  private let keynoteView = KeynoteView()
  
  // MARK: - Lifecycle
  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  override func loadView() {
    view = keynoteView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print( UniqueIDRandomGenerator().randValue())
    print("test")
    _=(0..<5).map { _ in
      let a = UniqueIdRandomGeneratorStorage.shared
      let t = a.create()
      print(t)

    }
  }
}
