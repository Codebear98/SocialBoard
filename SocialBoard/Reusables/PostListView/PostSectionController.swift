//
//  PostSectionController
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import UIKit
import IGListKit

private enum Section {
  static let image = "image"
  static let spinner = "spinner"
  static let action = "action"
}

class PostSectionController: ListBindingSectionController<ListDiffable> {
  
  override init() {
    super.init()
    dataSource = self
//    selectionDelegate = self
    
    inset = UIEdgeInsets(top:0, left: 0, bottom: 10, right: 0)
    self.minimumInteritemSpacing = 5
    self.minimumLineSpacing = 0
    
  }
}

extension PostSectionController: ListBindingSectionControllerDataSource {
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                         viewModelsFor object: Any) -> [ListDiffable] {
    guard let postVM = object as? PostListItemViewModel else { return [] }
    
    var viewModels = [ListDiffable]()
    viewModels.append(LabelViewModel(postVM.title ?? ""))
    viewModels.append(FullWidthLabelViewModel(postVM.body ?? ""))
    viewModels.append(ActionCellViewModel(postVM.model.id))
    
    
    return viewModels
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
    
    var cellClass: AnyClass = LabelCell.self
    
    switch viewModel {
    case is LabelViewModel:
      cellClass = LabelCell.self
    case is DetailViewModel:
      cellClass = DetailLabelCell.self
    case is FullWidthLabelViewModel:
      cellClass = FullWidthSelfSizingCell.self
    case is ActionCellViewModel:
      cellClass = ActionCell.self
    default:
      cellClass = LabelCell.self
    }
    
    let cell = collectionContext?.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
    
    return cell ?? LabelCell()
  }
  
  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                         sizeForViewModel viewModel: Any,
                         at index: Int) -> CGSize {
    guard let width = collectionContext?.containerSize.width else { return .zero }
  
    switch viewModel {
    case is LabelViewModel:
      return CGSize(width: width, height: 30.0)
    case is FullWidthLabelViewModel:
      return CGSize(width: width, height: 100.0)
    case is ActionCellViewModel:
      return CGSize(width: width, height: 30)
    default:
      return CGSize(width: width, height: 50.0)
    }

  }
}

//extension PostsSectionController: ListBindingSectionControllerSelectionDelegate {
//
//  func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
//    guard let postVM = viewModel as? PostViewModel else { return }
//
////    update(animated: true)
//  }
//}
