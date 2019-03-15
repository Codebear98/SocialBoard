//
//  MLTextProcessor.swift
//  SocialBoard
//
//  Created by henry.hong on 13/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import CoreML

struct SpamDetector {
  
  func process (msg: String,
                completion: @escaping ((String?, [String: Double]? ) -> Void)) {
    
    let vec = tfidf(sms: msg)
    do {
      let prediction = try MessageClassifier().prediction(message: vec)
      
      print("prediction: \(prediction.label)")
      
      completion(prediction.label, prediction.classProbability)
    } catch {
      completion(nil, nil)
    }
  }
}


extension SpamDetector {
  
  func tfidf(sms: String) -> MLMultiArray{
    let wordsFile = Bundle.main.path(forResource: "words_ordered", ofType: "txt")
    let smsFile = Bundle.main.path(forResource: "SMSSpamCollection", ofType: "txt")
    do {
      let wordsFileText = try String(contentsOfFile: wordsFile!, encoding: String.Encoding.utf8)
      var wordsData = wordsFileText.components(separatedBy: .newlines)
      wordsData.removeLast() // Trailing newline.
      let smsFileText = try String(contentsOfFile: smsFile!, encoding: String.Encoding.utf8)
      var smsData = smsFileText.components(separatedBy: .newlines)
      smsData.removeLast() // Trailing newline.
      let wordsInMessage = sms.split(separator: " ")
      let vectorized = try MLMultiArray(shape: [NSNumber(integerLiteral: wordsData.count)], dataType: MLMultiArrayDataType.double)
      for i in 0..<wordsData.count{
        let word = wordsData[i]
        if sms.contains(word){
          var wordCount = 0
          for substr in wordsInMessage{
            if substr.elementsEqual(word){
              wordCount += 1
            }
          }
          let tf = Double(wordCount) / Double(wordsInMessage.count)
          var docCount = 0
          for sms in smsData{
            if sms.contains(word) {
              docCount += 1
            }
          }
          let idf = log(Double(smsData.count) / Double(docCount))
          vectorized[i] = NSNumber(value: tf * idf)
        } else {
          vectorized[i] = 0.0
        }
      }
      return vectorized
    } catch {
      return MLMultiArray()
    }
  }
  
}
