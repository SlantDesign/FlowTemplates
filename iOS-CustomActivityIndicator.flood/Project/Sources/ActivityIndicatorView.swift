//
//  ActivityIndicatorView.swift
//  Loader
//
//  Created by Travis on 2020-04-15.
//  Copyright © 2020 Travis. All rights reserved.
//
import Foundation
import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
  public private(set) var view: UIView!

  var timeline: Timeline? {
    return nil
  }

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

  private func setup() {
    view = createView()
    addSubview(view)
  }

  func handleAnimating() {
    if isAnimating {
      timeline?.play()
    }
  }

  override func startAnimating() {
    super.startAnimating()
    timeline?.play()
  }

  override func stopAnimating() {
    super.stopAnimating()
    timeline?.pause()
    timeline?.offset(to: 0)
  }
}
