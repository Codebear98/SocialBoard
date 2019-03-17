//
//  CollectionViewController.swift
//  SocialBoard
//
//  Created by henry.hong on 16/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import UIKit


class CollectionViewController: UIViewController {
  
  var collectionView:UICollectionView!
  var sizeForTopOfCollectionView:CGFloat!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setCollectionView()
  }
  
  func setCollectionView() {
    
    sizeForTopOfCollectionView = 0
    
    collectionView = UICollectionView(frame:CGRect(x:0,y: sizeForTopOfCollectionView,
                                                   width: UIScreen.main.bounds.width,
                                                   height: UIScreen.main.bounds.height-sizeForTopOfCollectionView),
                                      collectionViewLayout: UICollectionViewFlowLayout())
    collectionView?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    view.addSubview(collectionView!)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    sizeForTopOfCollectionView = 0
    collectionView.frame = CGRect(x:0,
                                  y: sizeForTopOfCollectionView,
                                  width: UIScreen.main.bounds.width,
                                  height: UIScreen.main.bounds.height-sizeForTopOfCollectionView)
    
    guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
      return
    }
    
    flowLayout.invalidateLayout()
  }
}
