//
//  Launcher.swift
//  SocialBoard
//
//  Created by henry.hong on 11/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import UIKit

class Launcher {
  static var window: UIWindow {
    return UIWindow(frame: UIScreen.main.bounds)
  }
  
  static func launch(with window: UIWindow?,
                     completion: @escaping (() -> Void)) {
    let homeVC = HomeViewController()
    window?.rootViewController = homeVC
    completion()
  }
}
