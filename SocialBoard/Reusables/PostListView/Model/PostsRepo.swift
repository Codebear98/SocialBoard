//
//  PostsModel.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit
import Moya
import RxSwift
import RxCocoa

class PostsRepo: BaseModel {
  
  typealias DataType = [SBPost]
  
  init(api: MoyaProvider<SBService> = MoyaProvider<SBService>()) {
    _api = api
  }
  private let _api: MoyaProvider<SBService>
  
  var data = BehaviorRelay<[SBPost]>(value: [])

  func requestPost(_ paging: Paging, complete:@escaping (_ succeed :Bool)->()){
    _api.request(SBService.latestPosts(paging: paging)) { [weak self] result in
      guard let self = self else {
        complete(false)
        return
      }
      if case let .success(response) = result,
        let newPosts = try? response.filterSuccessfulStatusCodes().map([SBPost].self) {
        let mergedPosts = self.data.value.getMergedElements(newElements: newPosts)
        let hasReachTheEnd = (mergedPosts.count - self.data.value.count) < paging.limit
        self.data.accept(mergedPosts)
        complete(!hasReachTheEnd)

         // append new and remove duplicate
         // if hasReachTheEnd means the paging is not completed. should remain the same paging and try again next time.
      } else {
        print("request url: \(result.value?.request?.url?.absoluteString ?? "")")
        complete(false)
      }
    }
  }
}

extension PostsRepo: ListDiffable {
  
  func diffIdentifier() -> NSObjectProtocol {
    return "PostsRepo" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? PostsRepo else { return false }
    return data.value.elementsEqual(object.data.value)
  }
}
