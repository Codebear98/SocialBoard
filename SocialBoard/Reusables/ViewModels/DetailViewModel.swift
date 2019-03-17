//
//  DetailsViewModel.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit

final class DetailViewModel: ListDiffable {
  
  let title: String
  let detail: String
  
  init(_ title: String, detail: String) {
    self.title = title
    self.detail = detail
  }
  
  // MARK: ListDiffable
  
  func diffIdentifier() -> NSObjectProtocol {
    return "detail" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? DetailViewModel else  { return false }
    return title == object.title && detail == object.detail
  }
}
