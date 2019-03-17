//
//  CommentViewModel.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit

class CommentViewModel: BaseViewModel, ListDiffable {
  
  var model: SBComment?
  let email: String?
  let text: String?
  
  init(_ model: SBComment) {
    self.email = model.email
    self.text = model.name
    self.model = model
  }
  
  // MARK: ListDiffable
  
  func diffIdentifier() -> NSObjectProtocol {
    return "comment_\(model?.id ?? 0)" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? CommentViewModel else  { return false }
    return text == object.text && email == object.email
  }
}
