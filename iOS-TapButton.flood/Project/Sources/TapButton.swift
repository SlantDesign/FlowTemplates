// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import Foundation
import UIKit

class TapButton: UIButton {
    weak var delegate: TapButtonDelegate?
    var current: Timeline?
    var tapstate: TapButtonState = .up

    public var forward: Timeline? {
        return nil
    }

    public var reverse: Timeline? {
        return nil
    }

    public func createView() -> UIView {
        return UIView(frame: CGRect.null)
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
        forward?.play()
    }

    @objc
    func touchUp() {
        guard tapstate == .down else {
            return
        }
        tapstate = .up
        reverse?.play()
    }
}

protocol TapButtonDelegate: class {
    func didTap(sender: TapButton)
}

enum TapButtonState: Int {
    case down = 0, up
}
