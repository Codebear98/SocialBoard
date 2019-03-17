//
//  SBModel.swift
//  SocialBoardTests
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Quick
import Nimble
import Moya
import Moya.Swift
import Result
import RxSwift

@testable import SocialBoard

class ModelsSpec: QuickSpec {
  
  override func spec() {
    describe(String(describing: PostsRepo.self)) {
      let api = MoyaProvider<SBService>()
      let postModel = PostsRepo(api: api)
      let disposeBag = DisposeBag()
      
      context("When request nextPage") {
        postModel.data.accept([])
        it("should receive new posts", closure: {
          waitUntil (timeout: 5) { done in
            let count  = postModel.data.value.count
            postModel.data.asObservable().skip(1).take(1)
              .subscribe(onNext: { posts in
                expect(posts.count > count).to(beTrue())
                done()
              })
              .disposed(by: disposeBag)
            postModel.nextPage()
          }
        })
      }
    }
  }
}
