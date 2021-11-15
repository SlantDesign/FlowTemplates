// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

class Slider: UISlider {
    var view: UIView!

    public private(set) var timeline: Timeline!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        for subview in self.subviews {
            subview.isHidden = true
        }

        addTarget(self, action: #selector(update), for: .valueChanged)

        view = createView()
        addSubview(view)
        view.isUserInteractionEnabled = false
        timeline = createTimeline()
    }

    @objc
    func update() {
        timeline.offset(to: Double(value))
    }

    public func createTimeline() -> Timeline {
        return Timeline(view: view, animationsByLayer: [CALayer(): []], sounds: [], duration: 1)
    }

    public func createView() -> UIView {
        return UIView(frame: CGRect.null)
    }
}
