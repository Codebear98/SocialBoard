//
//  CommentsRepo.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit
import Moya
import RxSwift
import RxCocoa

class CommentsRepo: BaseModel {
  typealias DataType = [SBComment]
  
  init(api: MoyaProvider<SBService> = MoyaProvider<SBService>()) {
    _api = api
  }
  private let _api: MoyaProvider<SBService>
  
  var data = BehaviorRelay<[SBComment]>(value: [])
  
  func requestAllComments(_ postId: Int, complete:@escaping (_ succeed :Bool)->()){
    _api.request(SBService.showAllComments(postId: postId)) { [weak self] result in
      guard let self = self else {
        complete(false)
        return
      }
      if case let .success(response) = result,
        let items = try? response.filterSuccessfulStatusCodes().map([SBComment].self) {
        self.data.accept(items)
        complete(true)
      } else {
        print("request url: \(result.value?.request?.url?.absoluteString ?? "")")
        complete(false)
      }
    }
  }
}

extension CommentsRepo: ListDiffable {
  
  func diffIdentifier() -> NSObjectProtocol {
    return "CommentsRepo" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? CommentsRepo else { return false }
    return data.value.elementsEqual(object.data.value)
  }
}
