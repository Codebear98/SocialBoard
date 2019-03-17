//
//  SBUser.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import Moya

class SBUser: Decodable {
  let id: Int
  let name: String
  let username: String
  let email: String
  let address: SBAddress
  let phone: String
  let website: String
  let company: SBCompany
}

struct SBAddress: Decodable {
  let street: String
  let suite: String
  let city: String
  let zipcode: String
  let geo: SBGeo
  
}

struct SBCompany: Decodable {
  let name: String
  let catchPhrase: String
  let bs: String
}

struct SBGeo: Decodable {
  let lat: String
  let lng: String
}


extension SBUser: Equatable {
  public static func == (lhs: SBUser, rhs: SBUser) -> Bool {
    return lhs.id == rhs.id
  }
}
