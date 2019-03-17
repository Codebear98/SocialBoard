//
//  FullWidthSelfSizingViewModel.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit

class FullWidthLabelViewModel: BaseViewModel, ListDiffable {
  
  let text: String
  
  init(_ text: String) {
    self.text = text
  }
  
  // MARK: ListDiffable
  
  func diffIdentifier() -> NSObjectProtocol {
    return text as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? FullWidthLabelViewModel else  { return false }
    return text == object.text
  }
}

