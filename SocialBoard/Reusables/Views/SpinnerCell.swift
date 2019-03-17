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
import Lottie

final class SpinnerCell: UICollectionViewCell {

    lazy var activityIndicator: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .gray)
        self.contentView.addSubview(view)
        return view
    }()
  
    lazy var lotAnimationView: LOTAnimationView = {
      let lotView = LOTAnimationView(name: "animation-w800-h800")
      
      // Set view to full screen, aspectFill
      lotView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      lotView.contentMode = .scaleAspectFill
      lotView.frame = self.contentView.bounds.insetBy(dx: self.contentView.bounds.size.width/4, dy: 0)
      lotView.loopAnimation = true
      
      self.contentView.addSubview(lotView)
      return lotView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        lotAnimationView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

}



