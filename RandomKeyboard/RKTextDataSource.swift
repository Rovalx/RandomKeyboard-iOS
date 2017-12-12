//
//  RKTextDataSource.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 05.11.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

class RKTextDataSource {
    
    enum StoredData: String {
        case isConfigured = "configured"
        case emojiTexts = "emoji"
        case quotesTexts = "quotes"
        case singleWords = "words"
        case longTexts = "long"
        case password = "password"
        case logins = "logins"
    }
    
    /// This class is singleton, but remember each process (app/keyboard) has it's own
    static let shared = RKTextDataSource()
    
    fileprivate let source: UserDefaults!
    
    // MARK: Computed properties
    
    /// If all texts are properly added to source by main app this value is true
    var isConfigured: Bool {
        return source.bool(forData: .isConfigured)
    }
    
    private init() {
        self.source = UserDefaults(suiteName: "group.pl.majdumajdu.RandomKeyboard")
    }
    
    // MARK: Configuration
    
    func configureWithDefaults() {
        // Data source configure itself with default texts
        
        let plistReader = RKDefaultPlistReader()
        
        source.set(plistReader.emojiTexts, forData: .emojiTexts)
        source.set(plistReader.longTexts, forData: .longTexts)
        source.set(plistReader.shortTexts, forData: .quotesTexts)
        source.set(plistReader.singleWords, forData: .singleWords)
        source.set("Pass1234", forData: .password)
        source.set(["test@test.com", ], forData: .logins)
        source.set(true, forData: .isConfigured)
        
    }
    
}

// MARK: Texts source

extension RKTextDataSource {
    
    private var emojisTexts: [String] {
        return self.source.object(forData: .emojiTexts) as? [String] ?? []
    }
    var randomEmoji: String {
        return emojisTexts.randomItem() ?? ""
    }
    
    private var longTexts: [String] {
        return self.source.object(forData: .longTexts) as? [String] ?? []
    }
    var randomLongText: String {
        return longTexts.randomItem() ?? ""
    }
    
    private var quoteTexts: [String] {
        return self.source.object(forData: .quotesTexts) as? [String] ?? []
    }
    var randomQuoteText: String {
        return quoteTexts.randomItem() ?? ""
    }
    
    private var singleWords: [String] {
        return self.source.object(forData: .singleWords) as? [String] ?? []
    }
    var randomSingleWork: String {
        return singleWords.randomItem() ?? ""
    }
}

// MARK: Session source

extension RKTextDataSource {

    var password: String {
        set {
            source.set(newValue, forData: .password)
        }
        get {
            return source.object(forData: .password) as? String ?? ""
        }
    }
    
    var logins: [String] {
        set {
            source.set(newValue, forData: .logins)
        }
        get {
            return source.object(forData: .logins) as? [String] ?? []
        }
    }
    var randomLogin: String {
        return logins.randomItem() ?? ""
    }
    
}

fileprivate extension UserDefaults {
    
    func bool(forData option: RKTextDataSource.StoredData) -> Bool {
        return self.bool(forKey: option.rawValue)
    }
    
    func set(_ value: Any?, forData option: RKTextDataSource.StoredData) {
        self.set(value, forKey: option.rawValue)
    }
    
    func object(forData option: RKTextDataSource.StoredData) -> Any? {
        return object(forKey: option.rawValue)
    }
    
}

fileprivate extension Array {
    
    func randomItem() -> Element? {
        
        if self.count <= 0 {
            return nil
        }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
