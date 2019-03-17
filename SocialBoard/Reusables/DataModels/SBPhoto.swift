//
//  SBPhoto.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation

class SBPhoto: Decodable {
  let albumId: Int
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}

extension SBPhoto: Equatable {
  public static func == (lhs: SBPhoto, rhs: SBPhoto) -> Bool {
    return lhs.id == rhs.id
      && lhs.albumId == rhs.albumId
  }
}
