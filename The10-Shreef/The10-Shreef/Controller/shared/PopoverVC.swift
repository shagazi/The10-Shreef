//
//  PopoverVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/16/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

class PopoverVC: UIViewController {
//    @IBOutlet weak var popOverBottomConstraint: NSLayoutConstraint!
    //    @IBOutlet weak var popOverTopConstraint: NSLayoutConstraint!
//    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerView: UIView!

    private let containedVC: UIViewController
//    private var containerMinY = NSLayoutConstraint().constant

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

//        containerView.layer.applyBorder(cornerRadius: 24)
//        containerView.backgroundColor = UIColor.white
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 10

        containedVC.view.layer.cornerRadius = 24
//
//        let center = NotificationCenter.default
//        center.addObserver(self,
//                           selector: #selector(keyboardWillShow),
//                           name: UIResponder.keyboardWillShowNotification,
//                           object: nil)
//
//        center.addObserver(self,
//                           selector: #selector(keyboardWillHide),
//                           name: UIResponder.keyboardWillHideNotification,
//                           object: nil)

        containerView.addSubview(containedVC.view)
//        containerMinY = popOverTopConstraint.constant

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
        containedVC.view.frame.size = containerView.frame.size
        containedVC.view.topAnchor.constraint(equalTo: containerView.topAnchor)
        containedVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        containedVC.view.clipsToBounds = true
    }

    // MARK: - Private

    @objc private func dismissPopover(_ sender: UIGestureRecognizer) {
//        dismiss(animated: true, completion: nil)
        let location = sender.location(in: self.view)
        let viewToIgnore = self.view.hitTest(location, with: UIEvent())
        if viewToIgnore?.gestureRecognizers?.contains(sender) == .some(true) {
            dismiss(animated: true, completion: nil)
            self.view.endEditing(true)
        }
    }
//
//    @objc private func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        guard let keyboardAnimationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) else { return }
//        animateBottomConstraint(duration: keyboardAnimationDuration, topValue: 8, bottomValue: keyboardFrame.height - 20)
//    }
//
//    @objc private func keyboardWillHide(notification: NSNotification) {
//        guard let keyboardAnimationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) else { return }
//        animateBottomConstraint(duration: keyboardAnimationDuration, topValue: containerMinY, bottomValue: 20)
//    }

//    private func animateBottomConstraint(duration: Double, topValue: CGFloat, bottomValue: CGFloat) {
//        UIView.animate(withDuration: duration) {
//            self.popOverTopConstraint.constant = topValue
//            self.popOverBottomConstraint.constant = bottomValue
//            self.view.layoutIfNeeded()
//        }
//    }
}
