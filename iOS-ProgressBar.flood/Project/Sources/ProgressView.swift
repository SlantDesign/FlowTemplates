// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

class ProgressView: UIProgressView {

    public private(set) var view: UIView!
    private var observation: NSKeyValueObservation?

    override var observedProgress: Progress? {
        didSet {
            createObservation()
        }
    }

    var timeline: Timeline?

    public override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
      setup()
    }

    public func createView() -> UIView {
      return UIView(frame: CGRect.null)
    }

    private func setup() {
        for subview in self.subviews {
            subview.isHidden = true
        }
        view = createView()
        addSubview(view)
    }

    private func createObservation() {
        observation = nil
        observation = observedProgress?.observe(\.fractionCompleted, options: .new) { _, change in
            guard let timeline = self.timeline, let value = change.newValue else {
                return
            }
            if timeline.time != TimeInterval(value) {
                timeline.offset(to: value)
            }
        }
    }
}
