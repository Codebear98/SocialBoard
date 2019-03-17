//
//  InteractiveCell.swift
//  SocialBoard
//
//  Created by henry.hong on 17/3/2019.
//  Copyright © 2019 Life. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa
import Lottie

final class ActionCell: UICollectionViewCell {
  
  fileprivate let padding: CGFloat = 17.0
  private var disposeBag = DisposeBag()
  weak private var vm :ActionCellViewModel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy private var likeButton: LOTAnimatedSwitch = {
    let view = LOTAnimatedSwitch.init(named: "4385-first-shot")
    view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

    /// Turn off clips to bounds, as the animation goes outside of the bounds.
    view.clipsToBounds = false
    self.contentView.addSubview(view)
    
    view.addTarget(self, action: #selector(ActionCell.likeButtonTapped) , for: .touchDown)
    return view
  }()
  
  lazy private var likeLabel: UILabel = {
    let view = UILabel()
    view.backgroundColor = .clear
    view.textAlignment = .left
    view.font = .systemFont(ofSize: 17)
    view.textColor = .blue
    view.numberOfLines = 5
    self.contentView.addSubview(view)
    return view
  }()
  
  lazy private var commentButton: UIButton = {
    let view = UIButton()
    view.setTitle("6 Comments", for: .normal)
    view.setTitleColor(.darkText, for: .normal)
    view.backgroundColor = .clear
    view.sizeToFit()
    self.contentView.addSubview(view)
    return view
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let frame = contentView.bounds.insetBy(dx: padding, dy: 0)
    likeButton.frame = CGRect(x: frame.origin.x, y: 0, width: 30, height: 30)
    likeLabel.frame = CGRect(x: likeButton.frame.origin.x + likeButton.frame.size.width + 5, y: 0, width: 200, height: frame.size.height)
    commentButton.frame = CGRect(x: frame.origin.x + frame.size.width - 120, y: 0, width: 120, height: frame.size.height)
  }
  
  @objc func likeButtonTapped () {
    likeButton.isUserInteractionEnabled = false
    vm?.tappedLike()
  }
}

extension ActionCell: ListBindable {
  
  func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? ActionCellViewModel else { return }
    vm = viewModel
    self.disposeBag = DisposeBag()
    
    self.likeButton.isUserInteractionEnabled = !viewModel.isLiked
    self.likeButton.isOn = viewModel.isLiked
    
    viewModel.likeLabelTitleBehavior
    .asObservable()
    .bind(to: self.likeLabel.rx.text)
    .disposed(by: disposeBag)
    
    viewModel.commentLabelTitleBehavior
      .asObservable()
      .bind(to: self.commentButton.rx.title(for: .normal))
      .disposed(by: disposeBag)
  
  }
}


