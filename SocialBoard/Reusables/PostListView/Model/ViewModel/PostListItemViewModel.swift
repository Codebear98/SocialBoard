//
//  PostViewModel.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift
import RxCocoa

class PostListItemViewModel: BaseViewModel {
  
  var sizeCache: CGSize?
  var model:SBPost
  
  var title: String?
  var body: String?
  var authorName: String?
  
  init(model: SBPost) {
    self.model = model
    update()
  }
  
  private func update() {
    self.title = "#\(self.model.id): \(self.model.title)"
    self.body = self.model.body
  }
}

extension PostListItemViewModel: ListDiffable {
  
  func diffIdentifier() -> NSObjectProtocol {
    return "PostListItemViewModel_\(model.id)" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? PostListItemViewModel else { return false }
    return model.id == object.model.id && title == object.title && model == object.model
  }
}

