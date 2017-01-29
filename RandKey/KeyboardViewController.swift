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
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var clearKeyboardButton: UIButton!
    @IBOutlet var plainSentenceKeyboardButton: UIButton!
    @IBOutlet var longSentenceKeyboardButton: UIButton!
    @IBOutlet var textWithEmojiKeyboardButton: UIButton!
    @IBOutlet var singleWorkKeyboardButton: UIButton!
    @IBOutlet var dismissKeyboardButton: UIButton!
    @IBOutlet weak var image1KeyboardButton: UIButton!
    @IBOutlet weak var image2KeyboardButton: UIButton!
    @IBOutlet weak var infoKeyboardLabel: UILabel!
    
    // MARK: Properties
    
    /// Default data source for keyboard that will be used if nothing else provided
    private var defaultDataSource = RKDafaultDataSource()
    
    /// Data source implementation that will deliver all texts to keyboard
    public var dataSource: RKDataSource?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set default data source at init
        self.dataSource = self.defaultDataSource
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set default data source at init
        self.dataSource = self.defaultDataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInterface()
        self.setupKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // If not full access granted - show info label
        if !isOpenAccessGranted() {
            self.infoKeyboardLabel.text = "Enable full access to copy images"
        } else {
            self.infoKeyboardLabel.text = ""
        }
    }
    
    /// Loads keyboard view from nib
    private func loadInterface() {
        let randomKayNib = UINib(nibName: "RKDefaultView", bundle: nil)
        self.view = randomKayNib.instantiate(withOwner: self, options: nil)[0] as? UIView
    }
    
    
    /// Adds functionality to view 
    private func setupKeyboard() {
        
        // To next button add call to function moving to next keyboard
        self.nextKeyboardButton.addTarget(self,
                                          action: #selector(advanceToNextInputMode),
                                          for: .touchUpInside)
        
    }
    
    // MARK: Actions
    
    @IBAction func imageCopyAction(_ sender: UIButton) {
        
        // We can always get image from button
        if let img: UIImage = sender.image(for: .normal) {
            UIPasteboard.general.image = img
            self.infoKeyboardLabel.text = "Copied!"
        }
        
        
    }
    @IBAction func dismissKeyboardAction(_ sender: AnyObject) {
        
        self.dismissKeyboard()
        
    }
    
    @IBAction func insertPlainSentanceAction(_ sender: AnyObject) {
        print("Disp")
        self.insertText(text:
            self.dataSource?.shortTexts.randomItem() ?? "")
    }
    
    @IBAction func insertLongSentanceAction(_ sender: AnyObject) {
        self.insertText(text:
            self.dataSource?.longTexts.randomItem() ?? "")
    }
    
    @IBAction func insertTextWithEmojiAction(_ sender: AnyObject) {
        self.insertText(text:
            self.dataSource?.emojiTexts.randomItem() ?? "")
    }
    
    @IBAction func insertSingleWordAction(_ sender: AnyObject) {
        
        self.insertText(text:
            self.dataSource?.singleWords.randomItem() ?? "")
    }
    
    @IBAction func clearAction(_ sender: AnyObject) {
        self.clearText()
    }
    
    // MARK: Utils
    
    /// Clears the input field
    private func clearText() {
        
        // Remove letter as normal backspace
        let proxy = textDocumentProxy
        proxy.deleteBackward()
    }
    
    /// Inserts given text to input field and adds space at the end
    private func insertText(text: String) {
        let proxy = textDocumentProxy
        proxy.insertText(text + " ")
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
