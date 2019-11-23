//
//  HalfModal03NavigationController.swift
//  HalfModal
//
//  Created by Susumu Hoshikawa on 2019/11/23.
//  Copyright © 2019 Susumu Hoshikawa. All rights reserved.
//

import UIKit

class HalfModal03NavigationController: UINavigationController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = self.view.layer
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.black.cgColor
    }
}

// MARK: -

extension HalfModal03NavigationController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModal03PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: -

class HalfModal03PresentationController: UIPresentationController {

    private let margin: CGFloat = 6.0
    private let overlayView = UIView()
    
    /// 表示されるViewControllerのサイズを決める.
    override var frameOfPresentedViewInContainerView: CGRect {
        
        // 親ビューのbounds.
        guard let bounds = containerView?.bounds else { return .zero }
        
        return CGRect(
            x: margin,
            y: bounds.height * 0.2, // 上から20%くらいの位置に表示.
            width: bounds.width - margin * 2,
            height: bounds.height * 0.6 // 親の60%くらいの大きさに.
        )
    }
    
    /// 表示処理の開始.
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView else { return }
        
        // 表示トランジション開始前の処理.
        overlayView.frame = containerView.bounds
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        containerView.insertSubview(overlayView, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.overlayView.alpha = 0.5
        })
        
        // 背景をタップしたら、モーダルを閉じる.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(overlayViewDidTap(_:)))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    /// 表示処理の終了.
    /// - Parameter completed: 表示成功したかどうか.
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        print(#function)
    }
    
    /// 非表示処理の開始.
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // 非表示トランジション開始前の処理.
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.overlayView.alpha = 0.0
        })
    }
    
    /// 非表示処理の終了
    /// - Parameter completed: 非表示処理が成功したかどうか.
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        // 非表示トランジション終了時の処理.
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    @objc func overlayViewDidTap(_ sender: AnyObject) {
        presentedViewController.dismiss(animated: true) {
            print("dismiss !!")
        }
    }
}
