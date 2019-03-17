//
//  BaseView.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

protocol BaseView {
  associatedtype ModelType
  associatedtype ViewModelType
  
  var model: ModelType { get set }
  var viewModel: ViewModelType { get set }
}
