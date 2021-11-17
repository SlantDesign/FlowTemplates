import UIKit

class CustomRefreshControl: RefreshControl {
    private lazy var dialedView: DialedView = {
        return DialedView(frame: CGRect(origin: .zero, size: DialedView.Defaults.size))
    }()

    override func createView() -> UIView {
        return dialedView
    }

    override func createTimeline() -> Timeline {
        return DialedTimeline(view: dialedView, duration: 1, repeatCount: .greatestFiniteMagnitude)
    }
}
