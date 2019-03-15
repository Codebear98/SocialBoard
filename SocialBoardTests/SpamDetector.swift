//
//  SpamDetector.swift
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

@testable import SocialBoard

class SpamDetectorSpec: QuickSpec {
  
  override func spec() {
    
    describe(String(describing: SpamDetector.self)) {
      
      context("When predicting SPAM") {
        
        let msg = "Sale! Big Sale Now! BUY one get one FREE!!"
        
        it("should receive prediction", closure: {
          waitUntil (timeout: 5) { done in
            SpamDetector().process(msg: msg) { (label, dict) in
              
              print("label: \(String(describing: label))")
              print("dict: \(String(describing: dict))")
              
              expect(label).toNot(beNil())
              expect(dict).toNot(beNil())
              done()
            }
            
          }
        })
      }
    }
  }
}


