import UIKit

class RefreshControl: UIRefreshControl {
    struct Defaults {
        static let size = CGSize(width: 37, height: 37)
        static let resetDelay = 0.25
        static let alphaMin: CGFloat = 0.25
        static let alphaMax: CGFloat = 0.75
    }

    private var container: UIView!
    public private(set) var view: UIView!
    public private(set) var timeline: Timeline!

    override init() {
        super.init()
        frame = CGRect(origin: .zero, size: Defaults.size)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup() {
        view = createView()
        container = createContainer()
        setupViewConstraints()
        timeline = createTimeline()
        backgroundColor = view.backgroundColor
    }

    func createContainer() -> UIView {
        let containerView = UIView(frame: bounds)
        containerView.backgroundColor = view.backgroundColor
        view.alpha = 0
        view.backgroundColor = .clear
        containerView.addSubview(view)
        addSubview(containerView)
        return containerView
    }

    func setupViewConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false
        view.removeConstraints(view.constraints)
        view.centerXAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    func createView() -> UIView {
        return UIView()
    }

    func createTimeline() -> Timeline {
        return Timeline(view: view, animationsByLayer: [CALayer(): []], sounds: [], duration: 1, repeatCount: .greatestFiniteMagnitude)
    }

    override func endRefreshing() {
        super.endRefreshing()
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Defaults.resetDelay) {
            self.timeline.reset()
        }
    }

    // allows the custom refresh controller to mimic standard UIRefreshControl behaviour
    func process(offset: CGFloat) {
        if timeline.playing {
            return
        }

        if offset > 1 {
            timeline.play()
            view.layer.opacity = 1
        } else {
            timeline.offset(to: TimeInterval(offset))
            if offset > Defaults.alphaMin && offset < Defaults.alphaMax {
                view.alpha = (offset - Defaults.alphaMin) / (Defaults.alphaMax - Defaults.alphaMin)
            }
        }
    }
}
