//
//  PostsSectionViewModel.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift
import RxCocoa

class PostListViewModel: BaseViewModel {
  var sizeCache: CGSize?
  var model: PostsRepo
  var paging: Paging?
  var disposeBag = DisposeBag()
  
  var posts: [SBPost] {
    return model.data.value
  }
  
  let isLoadingBehavior = BehaviorRelay<Bool>(value: false)
  var isLoading: Bool {
    return isLoadingBehavior.value
  }
  var postVMsBehavior = BehaviorRelay<[PostListItemViewModel]>(value: [])
  var postVMs: [PostListItemViewModel] {
    return postVMsBehavior.value
  }
  
  init(model: PostsRepo = PostsRepo()) {
    self.model = model
    
    self.model.data.asObservable().subscribe({ [weak self] (event) in
      guard let self = self else { return }
      guard let posts = event.element else { return }
      
      let vms = posts.compactMap {
         PostListItemViewModel(model: $0)
      }
      self.postVMsBehavior.accept(vms)
      
    }).disposed(by: disposeBag)
  }
  
  func requestNewPage() {
    guard !self.isLoading else { return }
    
    self.isLoadingBehavior.accept(true)
    var new: Paging
    if let old = paging {
      new = Paging(page: old.page+1, limit: old.limit)
    } else {
      new = Paging(page: 1, limit: 10)
    }
    model.requestPost(new) {[weak self] (done) in
      if (done) {
        self?.paging = new
      }
      self?.isLoadingBehavior.accept(false)
    }
  }
}

extension PostListViewModel: ListDiffable {
  
  func diffIdentifier() -> NSObjectProtocol {
    return "PostListViewModel" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? PostListViewModel else { return false }
    return model.data.value.elementsEqual(object.model.data.value)
  }
}

