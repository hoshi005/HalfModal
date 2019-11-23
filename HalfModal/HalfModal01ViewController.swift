//
//  HalfModal01ViewController.swift
//  HalfModal
//
//  Created by shoshikawa on 2019/11/22.
//  Copyright © 2019 Susumu Hoshikawa. All rights reserved.
//

import UIKit

class HalfModal01ViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tap(_ sender: AnyObject) {
        dismiss(animated: true) {
            print("dismissed !!")
        }
    }
}

/// カスタムトランジションを定義するdelegate.
extension HalfModal01ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModal01PresentationController(presentedViewController: presented, presenting: presenting)
    }
}


/// UIPresentationControllerのサブクラスを定義する.
///
/// UIPresentationControllerは「ViewControllerをどのように表示するか？」を定義するクラス.
class HalfModal01PresentationController: UIPresentationController {
    
    /// 表示されるViewControllerのサイズを決める.
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(
            x: 0,
            y: (containerView?.bounds.height ?? 100) / 2,
            width: containerView?.bounds.width ?? 100,
            height: (containerView?.bounds.height ?? 100) / 2
        )
    }
    
    /// 表示処理の開始.
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        print(#function)
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
        print(#function)
    }
    
    /// 非表示処理の終了
    /// - Parameter completed: 非表示処理が成功したかどうか.
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        print(#function)
    }
}
