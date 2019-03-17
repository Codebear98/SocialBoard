//
//  BaseModel.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseModel {
  associatedtype DataType
  var data: BehaviorRelay<DataType> { get }
  
}
