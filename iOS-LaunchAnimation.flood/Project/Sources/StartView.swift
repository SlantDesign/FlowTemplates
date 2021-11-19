// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

@IBDesignable
public class StartView: UIView {
    public struct Defaults {
        public static let size = CGSize(width: 200, height: 200)
        public static let backgroundColor = UIColor.white
    }

    public var square: UIView!
    public var mainLabel: TextView!
    public var minorLabel: TextView!

    public override var intrinsicContentSize: CGSize {
        return Defaults.size
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = Defaults.backgroundColor
        clipsToBounds = false
        createViews()
        addSubviews()
        layer.name = "sceneLayer"
        //scale(to: frame.size)
    }

    /// Scales `self` and its subviews to `size`.
    ///
    /// - Parameter size: The size `self` is scaled to.
    ///
    /// UIKit specifies: "In iOS 8.0 and later, the transform property does not affect Auto Layout. Auto layout
    /// calculates a view's alignment rectangle based on its untransformed frame."
    ///
    /// see: https://developer.apple.com/documentation/uikit/uiview/1622459-transform
    ///
    /// If there are any constraints in IB affecting the frame of `self`, this method will have consequences on
    /// layout / rendering. To properly scale an animation, you will have to position the view manually.
    public func scale(to size: CGSize) {
        let x = size.width / Defaults.size.width
        let y = size.height / Defaults.size.height
        transform = CGAffineTransform(scaleX: x, y: y)
    }

    private func createViews() {
        CATransaction.suppressAnimations {
            createSquare()
            createMainLabel()
            createMinorLabel()
        }
    }

    private func createSquare() {
        square = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        square.backgroundColor = UIColor(red: 0.114, green: 0.114, blue: 0.086, alpha: 1)
        square.layer.shadowOffset = CGSize(width: 0, height: 3)
        square.layer.cornerRadius = 4
        square.layer.name = "square"
        square.layer.shadowColor = UIColor(red: 0.114, green: 0.114, blue: 0.086, alpha: 1).cgColor
        square.layer.shadowOpacity = 1
        square.layer.position = CGPoint(x: 100, y: 100)
        square.layer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.layer.masksToBounds = false

    }

    private func createMainLabel() {
        mainLabel = TextView(frame: CGRect(x: 100, y: 100, width: 141.71, height: 44.98))
        mainLabel.backgroundColor = UIColor.clear
        mainLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainLabel.layer.name = "mainLabel"
        mainLabel.layer.shadowColor = UIColor.clear.cgColor
        mainLabel.layer.shadowOpacity = 1
        mainLabel.layer.position = CGPoint(x: 100, y: 100)
        mainLabel.layer.bounds = CGRect(x: 0, y: 0, width: 141.71, height: 44.98)
        mainLabel.layer.masksToBounds = false
        mainLabel.textLayer.name = "mainLabel.textLayer"
        mainLabel.textLayer.string = """
            YOUR APP
            STARTS HERE
            """
        mainLabel.textLayer.font = "Rubik-Bold" as NSString
        mainLabel.textLayer.fontSize = 18
        mainLabel.textLayer.foregroundColor = UIColor.white.cgColor
        mainLabel.textLayer.alignmentMode = .center
        mainLabel.textLayer.truncationMode = .none
        mainLabel.textLayer.isWrapped = true

    }

    private func createMinorLabel() {
        minorLabel = TextView(frame: CGRect(x: 100, y: 178, width: 190.67, height: 25.32))
        minorLabel.backgroundColor = UIColor.clear
        minorLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        minorLabel.layer.name = "minorLabel"
        minorLabel.layer.shadowColor = UIColor.clear.cgColor
        minorLabel.layer.shadowOpacity = 1
        minorLabel.layer.position = CGPoint(x: 100, y: 178)
        minorLabel.layer.bounds = CGRect(x: 0, y: 0, width: 190.67, height: 25.32)
        minorLabel.layer.masksToBounds = false
        minorLabel.textLayer.name = "minorLabel.textLayer"
        minorLabel.textLayer.string = """
            Quit and relaunch the app
            to see your beautiful work again
            """
        minorLabel.textLayer.font = "Rubik-Light" as NSString
        minorLabel.textLayer.fontSize = 10
        minorLabel.textLayer.foregroundColor = UIColor.white.cgColor
        minorLabel.textLayer.alignmentMode = .center
        minorLabel.textLayer.truncationMode = .none
        minorLabel.textLayer.isWrapped = true

    }

    private func addSubviews() {
        addSubview(square)
        addSubview(mainLabel)
        addSubview(minorLabel)
    }
}