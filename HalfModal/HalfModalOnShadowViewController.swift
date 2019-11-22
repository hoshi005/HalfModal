//
//  HalfModalOnShadowViewController.swift
//  HalfModal
//
//  Created by shoshikawa on 2019/11/22.
//  Copyright © 2019 Susumu Hoshikawa. All rights reserved.
//

import UIKit

class HalfModalOnShadowViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = self.view.layer
        layer.cornerRadius = 36.0
//        layer.masksToBounds = false
//        layer.shadowRadius = 4.0
//        layer.shadowOffset = .zero
//        layer.shadowOpacity = 0.6
//        layer.shadowColor = UIColor.black.cgColor
    }
    
    @IBAction func tap(_ sender: AnyObject) {
        dismiss(animated: true) {
            print("dismissed !!")
        }
    }
}

/// カスタムトランジションを定義するdelegate.
extension HalfModalOnShadowViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalOnShadowPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


/// UIPresentationControllerのサブクラスを定義する.
///
/// UIPresentationControllerは「ViewControllerをどのように表示するか？」を定義するクラス.
class HalfModalOnShadowPresentationController: UIPresentationController {

    private let margin: CGFloat = 6.0
    private let overlayView = UIView()
    
    /// 表示されるViewControllerのサイズを決める.
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(
            x: margin,
            y: (containerView?.bounds.height ?? 100) / 2 - margin,
            width: (containerView?.bounds.width ?? 100) - margin * 2,
            height: (containerView?.bounds.height ?? 100) / 2
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

