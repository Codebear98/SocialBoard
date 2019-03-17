//
//  SBAlbum.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

class SBAlbum: Decodable {
  let userId: Int
  let id: Int
  let title: String?
}

extension SBAlbum: Equatable {
  public static func == (lhs: SBAlbum, rhs: SBAlbum) -> Bool {
    return lhs.id == rhs.id
      && lhs.userId == rhs.userId
  }
}
