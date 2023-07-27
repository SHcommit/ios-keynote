//
//  UIColor+.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/26.
//

import UIKit.UIColor

extension UIColor {
  convenience init(with rgb: RGBAModel.RGB, alpha: CGFloat) {
    let r = CGFloat(rgb.R)/255.0
    let g = CGFloat(rgb.G)/2550.0
    let b = CGFloat(rgb.B)/255.0
    self.init(red: r, green: g, blue: b, alpha: alpha)
  }
  
  func brightness() -> CGFloat {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r + g + b) / 3.0
  }
  
  func invertedAlpha() -> UIColor {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return UIColor(red: r, green: g, blue: b, alpha: 1.0 - a)
  }
  
  func toHexString() -> String {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    let redHex = String(format: "%02X", Int(r * 255))
    let greenHex = String(format: "%02X", Int(g * 255))
    let blueHex = String(format: "%02X", Int(b * 255))
    return "#" + redHex + greenHex + blueHex
  }
  
  static func colorWithHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor? {
    var hexWithoutSymbol = hex
    if hexWithoutSymbol.hasPrefix("#") {
      hexWithoutSymbol = String(hexWithoutSymbol.dropFirst())
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: hexWithoutSymbol).scanHexInt64(&rgbValue)
    
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }

}
