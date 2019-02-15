//
//  PresentationController.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import Foundation

class PresentationController: UIPresentationController {
    private var dimmingView: UIView!

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.view.layer.cornerRadius = 24.0
        presentedViewController.view.clipsToBounds = true
        setupDimmingView()
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView else { return CGRect.zero }
        let verticalOffset: CGFloat = 0.35 * containerView.bounds.height
        let bottomPadding = containerView.safeAreaInsets.bottom

        return CGRect(x: 20, y: verticalOffset,
                      width: containerView.bounds.width - 40,
                      height: containerView.bounds.height - verticalOffset - bottomPadding - 20)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.insertSubview(dimmingView, at: 0)
        containerView.constrain(subview: dimmingView)

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    // MARK: - Private

    private func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        self.dimmingView.addGestureRecognizer(gesture)
    }

    @objc private func dimmingViewTapped() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
