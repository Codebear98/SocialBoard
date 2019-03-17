//
//  AppConfig.swift
//  SocialBoard
//
//  Created by henry.hong on 13/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

enum Env {
  case production
  case staging
  case uat
}

struct AppConfig {
  
  static var shared = AppConfig()
  static private var _env: Env = .production
  
  static func setup(env: Env = .production) {
    _env = env
  }
  
  var env: Env {
    return AppConfig._env
  }
  
  var sbServerHost: String {
    switch env {
    case .uat:
      return Global.uatHost
    case .staging:
      return Global.stagingHost
    default:
      return Global.prodHost
    }
  }
}
