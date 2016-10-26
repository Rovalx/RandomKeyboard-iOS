//
//  RKDataSource.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 26.10.2016.
//  Copyright © 2016 Dominik Majda. All rights reserved.
//

import Foundation

/// Protocol that Keyboard view controller will be using for fetchin data to keyboard
public protocol RKDataSource: class {
    
    var shortTexts: [String] { get }
    var longTexts: [String] { get }
    var emojiTexts: [String] { get }
    var singleWords: [String] { get }
}

/// Default datasource containing strings shipped with this keyboard
class RKDafaultDataSource: RKDataSource {
    
    private var dictOfPossibleArrays: NSDictionary?
    
    var shortTexts: [String] {
        return self.dictOfPossibleArrays?["ShortTexts"] as? [String] ?? []
    }
    
    var longTexts: [String] {
        return self.dictOfPossibleArrays?["LongTexts"] as? [String] ?? []
    }
    
    var emojiTexts: [String] {
        return self.dictOfPossibleArrays?["EmojiTexts"] as? [String] ?? []
    }
    
    var singleWords: [String] {
        return self.dictOfPossibleArrays?["SingleWords"] as? [String] ?? []
    }
    
    /// Init array with plist added to this boundle.
    /// This plist contains all default texts.
    init() {
        
        guard let path = Bundle.main.path(forResource: "Texts", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) else {
                self.dictOfPossibleArrays = nil
                return
        }
        
        self.dictOfPossibleArrays = dict
    }
}
