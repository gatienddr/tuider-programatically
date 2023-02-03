//
//  Swipeable.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 08/01/2023.
//

import Foundation
import UIKit

// MARK: protocol
protocol Swipeable { }

// MARK: protocol extension constrained to UIPanGestureRecognizer
extension Swipeable where Self: UIPanGestureRecognizer {

    // MARK: function avaible for any UIPanGestureREcongnizer instance
    func swipeView(_ view: UIView) -> SwipeResult {

        var swipeResult: SwipeResult = .imprecise

        switch state {

        case .changed:
            let translation = self.translation(in: view.superview)
            view.transform = transform(view: view, for: translation)

        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 1.0, options: [], animations: {

                if view.transform.tx > 100 {
                    view.transform.tx = 400
                    view.isHidden = true
                    swipeResult = .like

                } else if view.transform.tx < -100 {
                    view.transform.tx = -400
                    view.isHidden = true
                    swipeResult = .refuse

                } else {
                    view.transform = .identity
                    swipeResult = .imprecise

                }
            }, completion: { _ in
                view.alpha = 1

                if swipeResult != .imprecise {

                    view.transform = CGAffineTransform.identity
                }

            })
        default:
            break

        }

        return swipeResult
    }

    // MARK: Helper method that handles transformation
    private func transform(view: UIView, for translation: CGPoint) -> CGAffineTransform {
        view.alpha = 1 - abs(0.001 * translation.x)
        let moveBy = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotation = sin(translation.x / (view.frame.width * 4.0))
        return moveBy.rotated(by: rotation)
    }
}

// MARK: UIPanGestureRecognizer conforming to Swipeable
extension UIPanGestureRecognizer: Swipeable {}
