//
//  APIClient.swift
//  SocialBoard
//
//  Created by henry.hong on 13/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import Moya

enum SBService {
  case latestPosts(paging: Paging)
  case showUsers(paging: Paging)
  case showUser(userId: Int)
  case showAlbum(userId: Int)
  case showComments(postId: Int, paging: Paging)
  case showPhotos(albumId: Int, paging: Paging)
}

struct Paging {
  let page: Int
  let limit: Int
  
  func query() -> String {
    return "_page=\(page)&_limit=\(limit)"
  }
  
  func params() -> [String: Any] {
    var params: [String: Any] = [:]
    params["_page"] = page
    params["_limit"] = limit
    return params
  }
}

// MARK: - TargetType Protocol Implementation
extension SBService: TargetType {
  
  var baseURL: URL { return URL(string: "https://\(AppConfig.shared.sbServerHost)")! }
  // not runtime dynamic variable, should crash the app to raise alert if something wrong.
  
  var path: String {
    switch self {
    case .latestPosts(_):
      return "/posts"
    case .showUsers(_):
      return "/users"
    case .showUser(let userId):
      return "/users/\(userId)"
    case .showAlbum(_):
      return "/albums"
    case .showComments(_,_):
      return "/comments"
    case .showPhotos(_,_):
      return "/photos"
    }
  }
  var method: Moya.Method {
    switch self {
    case .latestPosts(_),
         .showUsers(_),
         .showUser(_),
         .showAlbum(_),
         .showComments(_,_),
         .showPhotos(_,_):
      return .get
    }
  }
  var task: Task {
    switch self {
    case .latestPosts(let paging), .showUsers(let paging):
      // Always sends parameters in URL, regardless of which HTTP method is used
      return .requestParameters(parameters: paging.params(), encoding: URLEncoding.queryString)
    case .showAlbum(let userId):
      return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
    case .showComments(let postId):
      return .requestParameters(parameters: ["postId": postId], encoding: URLEncoding.queryString)
    case .showPhotos(let albumId):
      return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.queryString)
    default:
      return .requestPlain
    }
  }
  var sampleData: Data {
    return "No sample data".utf8Encoded
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}

// MARK: - Helpers
fileprivate extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}

