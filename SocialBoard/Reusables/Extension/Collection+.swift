//
//  Collection+safe.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

extension Collection {
  
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
