//
//  Common.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

struct Common {
  static let contentsFontSize: CGFloat = 20
  static let margin: CGFloat = 20
  static var toggle = false
  
  // Navigation
  static func navigtationViewController(scene: UIViewController) -> UIViewController {
    switch scene {
    case is KRTypingViewController:
      let krTypingViewController = KRTypingViewController()
      let krVC = UINavigationController(rootViewController: krTypingViewController)
      return krVC
    case is ENTypingViewController:
      let enTypingViewController = ENTypingViewController()
      let enVC = UINavigationController(rootViewController: enTypingViewController)
      return enVC
    case is EMJTypingViewController:
      let emjTypingViewController = EMJTypingViewController()
      let emjVC = UINavigationController(rootViewController: emjTypingViewController)
      return emjVC
    case is SWFTypingViewController:
      let swfTypingViewController = SWFTypingViewController()
      let swfVC = UINavigationController(rootViewController: swfTypingViewController)
      return swfVC
    default:
      let viewController = ViewController()
      let VC = UINavigationController(rootViewController: viewController)
      return VC
    }
  }
  // UIView buildView
  static func defaultView(for uiView: UIView, where addView: UIView) {
    uiView.backgroundColor = .white
    
    addView.addSubview(uiView)
  }
  // UILabel
  static func titleLabel(for uiLable: UILabel, title: String?, fontColor: UIColor,  textAlignment: NSTextAlignment?, where uiView: UIView) {
    uiLable.text = title ?? ""
    uiLable.textAlignment = textAlignment ?? .center
    uiLable.font = UIFont.boldSystemFont(ofSize: contentsFontSize * 10)
    
    uiView.addSubview(uiLable)
  }
  // UILabel
  static func contantsLabel(for uiLable: UILabel, title: String?, fontColor: UIColor, fontMultiplier: CGFloat,  textAlignment: NSTextAlignment?, where uiView: UIView) {
    uiLable.text = title ?? ""
    uiLable.textAlignment = textAlignment ?? .center
    uiLable.font = UIFont.boldSystemFont(ofSize: contentsFontSize * fontMultiplier)
    
    uiView.addSubview(uiLable)
  }
  // UITextField
  static func defaultTextField(for uiTextField: UITextField, placeholder: String, textAlignment: NSTextAlignment, keyboardType: UIKeyboardType, where uiView: UIView) {
    uiTextField.placeholder = placeholder
    uiTextField.textAlignment = textAlignment
    uiTextField.keyboardType = keyboardType
    uiTextField.font = UIFont.boldSystemFont(ofSize: contentsFontSize)
    uiTextField.textColor = .black
    uiTextField.autocapitalizationType = .none
    
    uiView.addSubview(uiTextField)
  }
  // Animation
  static func spreadFlagImage(ViewController VC: UIViewController, imageView IV: UIImageView) {
    UIView.animate(
      withDuration: 0.7,
      delay: 0,
      animations: {IV.transform = CGAffineTransform(scaleX: 15, y: 15)}
    ) { (true) in
      IV.isHidden = true
    }
  }
  static func shakeAnimagtion(targetLabel tL: UILabel, reverseTargetLabel rTL: UITextField) {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        tL.center.x -= 8
        rTL.center.x += 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        tL.center.x += 16
        rTL.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        tL.center.x -= 16
        rTL.center.x += 16
        
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        tL.center.x += 8
        rTL.center.x -= 8
      })
    })
  }
  static func twiceHartBeatAnimation(targetLabel label: UILabel) {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        label.transform = label.transform.scaledBy(x: 3, y: 3)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        label.transform = .identity
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        label.transform = label.transform.scaledBy(x: 5, y: 5)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        label.transform = .identity
      })
    })
  }
  static func hartBeatAnimation(targetLabel label: UILabel) {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        label.transform = label.transform.scaledBy(x: 1, y: 1)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        label.transform = .identity
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        label.transform = label.transform.scaledBy(x: 3, y: 3)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        label.transform = .identity
      })
    })
  }
}

// MARK: - Extension

extension UIView {
  var autoLayout: UIView {
    translatesAutoresizingMaskIntoConstraints.toggle()
    return self
  }
  @discardableResult // 반환타입이 있을때, 반환타입이 없어도 Warning이 생기지 않음
  func top(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.topAnchor
    topAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func leading(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.leadingAnchor
    leadingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func bottom(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.bottomAnchor
    bottomAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func trailing(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.trailingAnchor
    trailingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerYAnchor
    centerYAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
  @discardableResult
  func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
    let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerXAnchor
    centerXAnchor.constraint(equalTo: anchor, constant: c).isActive = true
    return self
  }
}

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}
