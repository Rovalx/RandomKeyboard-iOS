//
//  ViewController.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 26.10.2016.
//  Copyright © 2016 Dominik Majda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide navigation controller when entering this view
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show navigation controller when leaving this view
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: View customization
    
    private func setupView() {
        configureApp()
    }
    
    private func configureApp() {
        // First - check if app was not configured before
        if RKTextDataSource.shared.isConfigured {
            return
        }
        
        RKTextDataSource.shared.configureWithDefaults()
    }

    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

