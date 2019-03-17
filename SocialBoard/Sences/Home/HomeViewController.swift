//
//  HomeViewController.swift
//  SocialBoard
//
//  Created by henry.hong on 11/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

private enum Section {
  static let image = "image"
  static let spinner = "spinner"
}


class HomeViewController: CollectionViewController {
  lazy var adapter: ListAdapter = { return ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
  
  lazy var postListVM = PostListViewModel()
  lazy var items: [ListDiffable] = []
  let disposeBag = DisposeBag()
  
  func dataBinding() {
    adapter.collectionView = collectionView
    adapter.dataSource = self
    adapter.scrollViewDelegate = self

    let loadingEvent = postListVM.isLoadingBehavior.asObservable().distinctUntilChanged({
      return $0 == $1})
    let dataEvent = postListVM.postVMsBehavior.asObservable().distinctUntilChanged({
      return $0.elementsEqual($1, by: {return $0.isEqual(toDiffableObject: $1)})
    })
    Observable.combineLatest(loadingEvent, dataEvent) { ($0,$1) }
      .debounce(0.5, scheduler: MainScheduler.instance)
      .subscribe { [weak self] (event) in
      self?.adapter.performUpdates(animated: true)
      }.disposed(by: disposeBag)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataBinding()
    postListVM.requestNewPage()
  }
}

extension HomeViewController: ListAdapterDataSource {
  
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    var objects = items as [ListDiffable]
  
    objects.append(Section.image as ListDiffable)
    objects.append(contentsOf: postListVM.postVMs)
    
    if postListVM.isLoading {
      objects.append(Section.spinner as ListDiffable)
    }
    
    return objects
  }
  
  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    
    if let obj = object as? String {
      switch obj {
      case Section.image:
        return ImageCell.singleSectionController()
      case Section.spinner:
        return SpinnerCell.singleSectionController()
      default:
        return PostSectionController() // apply default Section
      }
    } else {
      return PostSectionController()
    }
  }
  
  func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
  
}


extension HomeViewController: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {

    let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
    if !postListVM.isLoading && distance < 200 {
      self.postListVM.requestNewPage()
      self.adapter.performUpdates(animated: false)
    }
  }
}

