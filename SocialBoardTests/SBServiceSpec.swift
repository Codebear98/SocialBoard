//
//  SBService.swift
//  SocialBoardTests
//
//  Created by henry.hong on 14/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Quick
import Nimble
import Moya
import Moya.Swift
import Result

@testable import SocialBoard

class SBServiceSpec: QuickSpec {
  
  override func spec() {
    
    describe(String(describing: SBServiceSpec.self)) {
      
      let paging = Paging(page: 2, limit: 2)
      let provider = MoyaProvider<SBService>()
      let responseValidate = { (result: Result<Response, MoyaError>) -> () in
        if case let .success(response) = result,
          let json = (try? response.filterSuccessfulStatusCodes().mapJSON()) {
          print("result: \(json)")
          expect(json).toNot(beNil())
        } else {
          print("request url: \(result.value?.request?.url?.absoluteString ?? "")")
          assertionFailure()
        }
      }
      
      context("When request latest post") {
        it("should receive response", closure: {
          waitUntil (timeout: 5) { done in
            provider.request(SBService.latestPosts(paging: paging)) { result in
              responseValidate(result)
              done()
            }
          }
        })
      }
      context("When request showAlbum") {
        it("should receive response", closure: {
          waitUntil (timeout: 5) { done in
            provider.request(SBService.showAlbum(userId: 1)) { result in
              responseValidate(result)
              done()
            }
          }
        })
      }
      
      context("When request showUsers") {
        it("should receive users data", closure: {
          waitUntil (timeout: 5) { done in
            provider.request(SBService.showUsers(paging: paging)) { result in
              responseValidate(result)
              done()
            }
          }
        })
      }
      
      context("When request showUser") {
        it("should receive response", closure: {
          waitUntil (timeout: 5) { done in
            provider.request(SBService.showUser(userId: 1)) { result in
              responseValidate(result)
              done()
            }
          }
        })
      }

      context("When request showComments") {
        it("should receive response", closure: {
          waitUntil (timeout: 5) { done in
            provider.request(SBService.showComments(postId: 3, paging: paging)) { result in
              responseValidate(result)
              done()
            }
          }
        })
      }
      context("When request showPhotos") {
        it("should receive response", closure: {
          waitUntil (timeout: 5) { done in
            provider.request(SBService.showPhotos(albumId: 1, paging: paging)) { result in
              responseValidate(result)
              done()
            }
          }
        })
      }
    }
  }
}

