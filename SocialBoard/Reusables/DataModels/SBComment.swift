//
//  SBComment.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

class SBComment: Decodable {
  let postId: Int
  let id: Int
  let name: String
  let email: String
  let body: String
}

extension SBComment: Equatable {
  public static func == (lhs: SBComment, rhs: SBComment) -> Bool {
    return lhs.id == rhs.id
      && lhs.postId == rhs.postId
  }
}
