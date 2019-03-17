//
//  Array+Merging.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
  public func getMergedElements<C : Collection>(newElements: C) -> [Element] where C.Iterator.Element == Element{
    let filteredList = newElements.filter({!self.contains($0)})
    return self + filteredList
  }
}

