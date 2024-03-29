// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import Foundation
import UIKit

class PushButton: UIButton {
    weak var delegate: PushButtonDelegate?
    var current: Timeline?
    var tapstate: PushButtonState = .up

    public private(set) var forward: Timeline!
    public private(set) var reverse: Timeline!

    public func createView() -> UIView {
        return UIView(frame: CGRect.null)
    }

    public func createForward() -> Timeline {
        return Timeline(view: UIView(), animationsByLayer: [CALayer(): []], sounds: [], duration: 1)
    }

    public func createReverse() -> Timeline {
        return Timeline(view: UIView(), animationsByLayer: [CALayer(): []], sounds: [], duration: 1).reversed
    }

    public private(set) var view: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        setupView()
        reverse = createReverse()
        forward = createForward()
        current = forward
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit])
    }

    private func setupView() {
        view = createView()
        view.isUserInteractionEnabled = false
        addSubview(view)
    }

    @objc
    func touchDown() {
        guard tapstate == .up else {
            return
        }
        tapstate = .down
        play(forward)
    }

    @objc
    func touchUp() {
        guard tapstate == .down else {
            return
        }
        tapstate = .up
        play(reverse)
    }

    func play(_ timeline: Timeline) {
        guard let current = current else {
            return
        }
        current.pause()
        let newTime = current.duration - current.time
        self.current = timeline
        self.current?.reset { timeline in
            timeline.offset(to: newTime)
            timeline.play()
        }
    }
}

protocol PushButtonDelegate: AnyObject {
    func didTap(sender: PushButton)
}

enum PushButtonState: Int {
    case down = 0, up
}
