//
//  AppDelegate.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    if #available(iOS 13.0, *) { }
    else {
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = LaunchViewController()
      window?.makeKeyAndVisible()
      
      
    }
    
    return true
  }
  
  
  
}

