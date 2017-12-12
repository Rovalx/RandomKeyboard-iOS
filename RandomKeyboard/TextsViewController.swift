//
//  TextsViewController.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 05.11.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

class TextsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupView()
    }
    
    // MARK: View customiztion
    
    private func setupView() {
        // Get rid of unwanted separators
        tableView.tableFooterView = UITableViewCell()
        
    }

}

extension TextsViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func registerNibs() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
