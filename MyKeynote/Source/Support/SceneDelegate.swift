//
//  SceneDelegate.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let rectModelFactory = RectModelFactory()
    let sm = SlideManager(rectModelFactory: rectModelFactory)
    let models = (0..<7)
      .map {_ in return SlideModel(state: .rect(sm.makeRectModel())) }
    models.forEach{ sm.add($0) }
    
    window?.rootViewController = KeynoteViewController(slideManager: sm)
    window?.makeKeyAndVisible()
  }
}
