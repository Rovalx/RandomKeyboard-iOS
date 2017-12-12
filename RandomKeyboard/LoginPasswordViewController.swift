//
//  LoginPasswordViewController.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 05.11.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

class LoginPasswordViewController: UIViewController, LoginCellDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var defaultPasswordTextField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var newLoginTextField: UITextField!
    
    // MARK: Properties
    /// We assign current logins to another array so we can update it on dismiss
    fileprivate var logins = RKTextDataSource.shared.logins
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupView()
        
    }
    
    deinit {
        // Save all data on deinit
        RKTextDataSource.shared.logins = logins
        RKTextDataSource.shared.password = defaultPasswordTextField.text ?? ""
    }
    
    // MARK: View customiztion
    
    private func setupView() {
        // Disable add button on start
        plusButton.isEnabled = false
        
        // Set default password text
        defaultPasswordTextField.text = RKTextDataSource.shared.password
    }

    // MARK: Actions
    
    @IBAction func loginTextChanged(_ sender: UITextField) {
        
        // Enable add button only if text not empty
        plusButton.isEnabled = !(sender.text?.isEmpty ?? true)
        
    }
    
    @IBAction func addLoginAction(_ sender: Any) {
        
        // We can force unwrap because this button is disabled if empty
        let newLogin = newLoginTextField.text!
        
        // Clear login text field, hide keyboard
        newLoginTextField.text = ""
        newLoginTextField.resignFirstResponder()
        plusButton.isEnabled = false
        
        // If login exists - do nothing
        if logins.contains(newLogin) {
            return
        }
        
        // Insert to table view with animation
        if logins.isEmpty {
            logins.append(newLogin)
            tableView.reloadData()
        } else {
            tableView.beginUpdates()
            logins.insert(newLogin, at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func remove(login: String) {
        // Remove certain login
        guard let indexOf = logins.index(of: login) else {
            return
        }
        
        // with animation (if any row remaining)
        if logins.count == 1 {
            logins.remove(at: indexOf)
            tableView.reloadData()
        } else {
            tableView.beginUpdates()
            logins.remove(at: indexOf)
            tableView.deleteRows(at: [IndexPath(row: indexOf, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension LoginPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // For login text field, add new login if possible
        if textField == newLoginTextField, plusButton.isEnabled {
            addLoginAction(textField)
        } else if textField == defaultPasswordTextField {
            // Just resign responder
            textField.resignFirstResponder()
        }
        
        return true
        
    }
    
}

extension LoginPasswordViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func registerNibs() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logins.isEmpty ? 1 : logins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if logins.isEmpty {
            // Return empty list cell
            return tableView.dequeueReusableCell(withIdentifier: "NoLoginsTableViewCell")!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LoginTableViewCell.cellIdentifier) as! LoginTableViewCell
        cell.login = logins[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    
}
