//
//  SBPost.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit

class SBPost: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

extension SBPost: Equatable {
  public static func == (lhs: SBPost, rhs: SBPost) -> Bool {
    return lhs.id == rhs.id
      && lhs.userId == rhs.userId
  }
}
//
extension SBPost: ListDiffable {
  
  func diffIdentifier() -> NSObjectProtocol {
    return "SBPost_\(id)" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? SBPost else { return false }
    return id == object.id &&
      userId == object.userId &&
      title == object.title &&
      body == object.body
  }
}

