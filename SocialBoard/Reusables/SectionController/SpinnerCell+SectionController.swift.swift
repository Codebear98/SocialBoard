
//
//  SpinnerCell.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit
import SDWebImage

extension SpinnerCell {
  static func singleSectionController() -> ListSingleSectionController {
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
      guard let cell = cell as? SpinnerCell else { return }
      cell.lotAnimationView.play(fromProgress: 0, toProgress: 1, withCompletion: nil)

    }
    
    let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
      guard let context = context else { return .zero }
      return CGSize(width: context.containerSize.width, height: 50)
    }
    
    return ListSingleSectionController(cellClass: SpinnerCell.self,
                                       configureBlock: configureBlock,
                                       sizeBlock: sizeBlock)
  }
}
