//
//  Activable.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

public let activityViewTag = (Int.max - 1)

public protocol Activable: class {

    func startActivityIndicator()
    func stopActivityIndicator()
}

extension UIView: Activable {

    @objc public func startActivityIndicator() {
        if let existingActivityView = viewWithTag(activityViewTag) {
            existingActivityView.removeFromSuperview()
        }

        let activityView = UIView(frame: bounds)
        var frame: CGRect = activityView.frame
        frame.origin.y -= 50
        frame.size.height += 100
        activityView.frame = frame
        activityView.backgroundColor = UIColor.clear
        activityView.alpha = 0
        activityView.tag = activityViewTag
        addSubview(activityView)
        let spinner = UIActivityIndicatorView(style: .medium)
        activityView.addSubview(spinner)
        spinner.center = activityView.center
        spinner.autoresizingMask = .flexibleTopMargin
        spinner.startAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            activityView.alpha = 1
        })
    }

    @objc public func stopActivityIndicator() {
        let activityView = viewWithTag(activityViewTag)

        if let activityView = activityView {

            UIView.animate(withDuration: 0.2, animations: {
                activityView.alpha = 0
            }, completion: { _ in
                activityView.removeFromSuperview()
            })
        }
    }
}

extension Activable where Self: UIViewController {

    public func startActivityIndicator() {
        view.startActivityIndicator()
    }

    public func stopActivityIndicator() {
        view.stopActivityIndicator()
    }
}
