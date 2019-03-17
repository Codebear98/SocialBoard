/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
 
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import IGListKit

final class DetailLabelCell: UICollectionViewCell {
  
  fileprivate let padding: CGFloat = 24.0
  
  lazy private var titleLabel: UILabel = {
    let view = UILabel()
    view.backgroundColor = .clear
    view.textAlignment = .left
    view.font = .boldSystemFont(ofSize: 20)
    view.textColor = .darkText
    view.numberOfLines = 2
    self.contentView.addSubview(view)
    return view
  }()
  
  lazy private var detailLabel: UILabel = {
    let view = UILabel()
    view.backgroundColor = .clear
    view.textAlignment = .left
    view.font = .systemFont(ofSize: 17)
    view.textColor = .darkText
    view.numberOfLines = 5
    self.contentView.addSubview(view)
    return view
  }()
  
  var title: String? {
    get {
      return titleLabel.text
    }
    set {
      titleLabel.text = newValue
    }
  }
  
  var detail: String? {
    get {
      return detailLabel.text
    }
    set {
      detailLabel.text = newValue
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let frame = contentView.bounds.insetBy(dx: padding, dy: 0)
    let titleSize = titleLabel.sizeThatFits(frame.size)
    let detailSize = detailLabel.sizeThatFits(frame.size)
    titleLabel.frame = CGRect(x: padding,
                              y: 0,
                              width: frame.size.width - (padding*2),
                              height: titleSize.height)
    detailLabel.frame = CGRect(x: padding + titleLabel.frame.origin.x + titleLabel.frame.size.width,
                               y: 0,
                               width: frame.width - (padding*2) - titleLabel.frame.size.width,
                               height: detailSize.height)
  }
}

extension DetailLabelCell: ListBindable {
  
  func bindViewModel(_ viewModel: Any) {
    guard let viewModel = viewModel as? DetailViewModel else { return }
    self.title = viewModel.title
    self.detail = viewModel.detail
  }
}
