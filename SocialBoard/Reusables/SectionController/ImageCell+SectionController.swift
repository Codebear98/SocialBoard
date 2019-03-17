//
//  PhotoSectionController.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import Foundation
import IGListKit
import SDWebImage

extension ImageCell {
  static func singleSectionController() -> ListSingleSectionController {
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
      guard let cell = cell as? ImageCell else { return }
      let url = URL(string: "https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg")
      let image = UIImage(named: "no-image-placeholder-big.jpg")
      cell.setImage(url: url, placeholder: image)
    }
    
    let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
      guard let context = context else { return .zero }
      return CGSize(width: context.containerSize.width, height: 250)
    }
    
    return ListSingleSectionController(cellClass: ImageCell.self,
                                       configureBlock: configureBlock,
                                       sizeBlock: sizeBlock)
  }
}
