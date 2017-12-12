//
//  LoginTableViewCell.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 05.11.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

protocol LoginCellDelegate: class {
    func remove(login: String)
}

class LoginTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var loginLabel: UILabel!
    
    // MARK: Properties
    static let cellIdentifier = "LoginTableViewCell"
    var login: String? {
        didSet {
            loginLabel.text = login
        }
    }
    weak var delegate: LoginCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: Actions
    @IBAction func deleteAction(_ sender: Any) {
        if let login = login {
            delegate?.remove(login: login)
        }
    }
}
