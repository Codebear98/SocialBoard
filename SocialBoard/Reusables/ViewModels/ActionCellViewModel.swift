//
//  ActionCellViewModel.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import IGListKit
import Moya

class ActionCellViewModel: BaseViewModel {
  var model: CommentModel
  var postId: Int {
    return model.postId
  }
  
  var isLiked: Bool = false
//  let likeButtonStatusBehavior: BehaviorRelay<Bool>
  let likeButtonTitleBehavior: BehaviorRelay<String>
  let likeLabelTitleBehavior: BehaviorRelay<String>
  let commentLabelTitleBehavior: BehaviorRelay<String>
  
  init(_ postId: Int) {
    self.model = CommentModel(postId)
    likeButtonTitleBehavior = BehaviorRelay<String>(value: "Like")
    likeLabelTitleBehavior = BehaviorRelay<String>(value: "\(model.likeCount)")
    commentLabelTitleBehavior = BehaviorRelay<String>(value: "Comments")
    
    self.model.requestUpdate {
      self.commentLabelTitleBehavior.accept("\(self.model.commentCount) Comments")
    }
  }

  func tappedLike() {
    guard !isLiked else { return }
    isLiked = true
    model.likeCount = model.likeCount + 1
    likeLabelTitleBehavior.accept("\(model.likeCount)")
  }
  func tappedComment(){
    
  }
}


extension ActionCellViewModel: ListDiffable {
  
  func diffIdentifier() -> NSObjectProtocol {
    return "ActionCellViewModel_\(postId)" as NSObjectProtocol
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? ActionCellViewModel else  { return false }
    return object.postId == postId
  }
}

class CommentModel: BaseViewModel {
  
  let repo = CommentsRepo()
  var likeCount: Int = 0
  var commentCount: Int = 0
  
  let postId: Int
  init(_ postId: Int) {
    self.postId = postId
  }
  
  func requestUpdate(completed: @escaping ()->() ) {
    repo.requestAllComments(postId) { [weak self] (succeed) in
      guard let self = self else { return }
      self.commentCount = self.repo.data.value.count
      completed()
    }
  }
}
