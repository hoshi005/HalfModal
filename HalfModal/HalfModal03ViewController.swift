//
//  HalfModal03ViewController.swift
//  HalfModal
//
//  Created by Susumu Hoshikawa on 2019/11/23.
//  Copyright © 2019 Susumu Hoshikawa. All rights reserved.
//

import UIKit

class HalfModal03ViewController: UITableViewController {
    
    private let CORNER_RADIUS: CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // ナビゲーションバーの上部２箇所を角丸.
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.layer.cornerRadius = CORNER_RADIUS
            navigationBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            navigationBar.clipsToBounds = true
        }
        
        // Viewの４隅を角丸.
        let layer = self.view.layer
        layer.cornerRadius = CORNER_RADIUS
        
        // スクロール領域の微調整.
        tableView.contentInset.bottom = CORNER_RADIUS
        tableView.verticalScrollIndicatorInsets.bottom = CORNER_RADIUS
    }
    
    @IBAction func tap(_ sender: AnyObject) {
        dismiss(animated: true) {
            print("dismissed !!")
        }
    }
    
    // MARK: - UITableViewControllerDataSource.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        cell.detailTextLabel?.text = "AAA"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
    }
    
    // MARK: - UITableViewControllerDelegate.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
