//
//  Router.swift
//  SocialBoard
//
//  Created by henry.hong on 11/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import UIKit


protocol Router {
  func route(
    to routeID: String,
    from context: UIViewController,
    parameters: Any?
  )
}
