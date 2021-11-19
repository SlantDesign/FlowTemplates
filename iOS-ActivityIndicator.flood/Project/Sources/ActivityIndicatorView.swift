// Made with Flow.

import Foundation
import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
  public private(set) var view: UIView!

  var timeline: Timeline!

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  public func createView() -> UIView {
    return UIView(frame: CGRect.null)
  }

  public func createTimeline() -> Timeline {
    return Timeline(view: UIView(), animationsByLayer: [CALayer(): []], sounds: [], duration: 1, repeatCount: .greatestFiniteMagnitude)
  }

  private func setup() {
    for subview in subviews {
        subview.isHidden = true
    }
    view = createView()
    timeline = createTimeline()
    addSubview(view)
  }

  func handleAnimating() {
      timeline.play()
  }

  override func startAnimating() {
    super.startAnimating()
    timeline.play()
  }

  override func stopAnimating() {
    super.stopAnimating()
    timeline.pause()
    timeline.offset(to: 0)
  }
}
