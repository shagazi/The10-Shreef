//
//  PopoverVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/16/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

class PopoverVC: UIViewController {
    @IBOutlet weak var containerView: UIView!

    private let containedVC: UIViewController
    private var containerSize = CGSize()

    init(viewController: UIViewController) {
        containedVC = viewController
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen

        containedVC.willMove(toParent: self)
        addChild(containedVC)
        containedVC.didMove(toParent: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 10

        containedVC.view.layer.cornerRadius = 24
        containerSize = containedVC.view.bounds.size

        containerView.addSubview(containedVC.view)
        containerView.constrain(subview: containedVC.view)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopover))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissPopover))
        swipe.direction = .down
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(swipe)
        tap.cancelsTouchesInView = false
        swipe.cancelsTouchesInView = false

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.frame.size = containerSize
        containedVC.view.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func dismissPopover(_ sender: UIGestureRecognizer) {
        let location = sender.location(in: self.view)
        let viewToIgnore = self.view.hitTest(location, with: UIEvent())
        if viewToIgnore?.gestureRecognizers?.contains(sender) == .some(true) {
            dismiss(animated: true, completion: nil)
            self.view.endEditing(true)
        }
    }
}
