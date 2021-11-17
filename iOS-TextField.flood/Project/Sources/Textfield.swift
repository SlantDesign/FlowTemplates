// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

class TextField: UITextField, UITextFieldDelegate {
    public private(set) var view: UIView!

    var forward: Timeline {
        return Timeline(view: view, animationsByLayer: [CALayer(): []], sounds: [], duration: 1)
    }

    var reverse: Timeline {
        return Timeline(view: view, animationsByLayer: [CALayer(): []], sounds: [], duration: 1).reversed
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        view = createView()

        view.isUserInteractionEnabled = false

        addSubview(view)
        sendSubviewToBack(view)

        delegate = self
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 10))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 10))
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if text == nil || text == "" {
            forward.play()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if text == nil || text == "" {
            reverse.play()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }

    func createView() -> UIView {
        return UIView()
    }
}

