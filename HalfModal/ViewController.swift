//
//  ViewController.swift
//  HalfModal
//
//  Created by shoshikawa on 2019/11/22.
//  Copyright © 2019 Susumu Hoshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tap01(_ sender: AnyObject) {
        if let vc = storyboard?.instantiateViewController(identifier: "HalfModal01ViewController") {
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true) {
                print("presented !!")
            }
        }
    }
    
    @IBAction func tap02(_ sender: AnyObject) {
        if let vc = storyboard?.instantiateViewController(identifier: "HalfModal02ViewController") {
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true) {
                print("presented !!")
            }
        }
    }
    
    @IBAction func tap03(_ sender: AnyObject) {
        if let vc = storyboard?.instantiateViewController(identifier: "HalfModal03ViewController") {
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true) {
                print("presented !!")
            }
        }
    }
}
