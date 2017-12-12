//
//  KeyboardViewController.swift
//  RandomKay
//
//  Created by Dominik Majda on 26.10.2016.
//  Copyright © 2016 Dominik Majda. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    // MARK: Outlet
    @IBOutlet weak var configurationView: UIView!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var appConfiguredTickImageView: UIImageView!
    @IBOutlet weak var openAccessTickImageView: UIImageView!
    
    // MARK: Properties
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }
    
    /// Loads keyboard view from nib
    private func loadInterface() {
        let randomKayNib = UINib(nibName: "RKDefaultView", bundle: nil)
        self.view = randomKayNib.instantiate(withOwner: self, options: nil)[0] as? UIView
    }
    
    
    /// Adds functionality to view 
    private func setupKeyboard() {
        if isOpenAccessGranted(), RKTextDataSource.shared.isConfigured {
            keyboardView.isHidden = false
            configurationView.isHidden = true
        } else {
            openAccessTickImageView.alpha = isOpenAccessGranted() ? 1.0 : 0.2
            appConfiguredTickImageView.alpha = RKTextDataSource.shared.isConfigured ? 1.0 : 0.2
            
            configurationView.isHidden = false
            keyboardView.isHidden = true
        }
    }
    
    // MARK: Image actions
    
    @IBAction func imageCopyAction(_ sender: UIButton) {
        
        // We can always get image from button
        if let img: UIImage = sender.image(for: .normal) {
            UIPasteboard.general.image = img
        }
        
        
    }
    
    // MARK: Text actions
    
    @IBAction func insertPlainSentanceAction(_ sender: AnyObject) {
        let quoteText = RKTextDataSource.shared.randomQuoteText
        self.insertText(text: quoteText)
    }
    
    @IBAction func insertLongSentanceAction(_ sender: AnyObject) {
        let longText = RKTextDataSource.shared.randomLongText
        self.insertText(text: longText)
    }
    
    @IBAction func insertTextWithEmojiAction(_ sender: AnyObject) {
        let emojiText = RKTextDataSource.shared.randomEmoji
        self.insertText(text: emojiText)
    }
    
    @IBAction func insertSingleWordAction(_ sender: AnyObject) {
        let singleWord = RKTextDataSource.shared.randomSingleWork
        self.insertText(text: singleWord)
    }
    
    // MARK: Settings actions
    
    @IBAction func dismissKeyboardAction(_ sender: AnyObject) {
        dismissKeyboard()
    }
    
    @IBAction func nextKeyboardAction(_ sender: AnyObject) {
        self.advanceToNextInputMode()
    }
    
    @IBAction func clearAction(_ sender: AnyObject) {
        self.clearText()
    }
    
    // MARK: Session actions
    
    @IBAction func loginAction(_ sender: Any) {
        let login = RKTextDataSource.shared.randomLogin
        self.insertText(text: login, withSpace: false)
    }
    
    @IBAction func passwordAction(_ sender: Any) {
        let password = RKTextDataSource.shared.password
        self.insertText(text: password, withSpace: false)
    }
    
    // MARK: Utils
    
    /// Clears the input field
    private func clearText() {
        
        // Remove letter as normal backspace
        let proxy = textDocumentProxy
        proxy.deleteBackward()
    }
    
    /// Inserts given text to input field and adds space at the end
    private func insertText(text: String, withSpace addSpace: Bool = true) {
        let proxy = textDocumentProxy
        proxy.insertText(text)
        if addSpace {
            proxy.insertText(" ")
        }
    }
    
    // Checks if full access granted
    func isOpenAccessGranted() -> Bool {
        
        if #available(iOSApplicationExtension 10.0, *) {
            UIPasteboard.general.string = "TEST"
            
            if UIPasteboard.general.hasStrings {
                // Enable string-related control...
                UIPasteboard.general.string = ""
                return  true
            } else {
                UIPasteboard.general.string = ""
                return  false
            }
        } else {
            // Fallback on earlier versions
            if UIPasteboard.general.isKind(of: UIPasteboard.self) {
                return true
            } else {
                return false
            }
            
        }
        
    }
}
