//
//  ArrayExtension.swift
//  RandomKeyboard
//
//  Created by Dominik Majda on 26.10.2016.
//  Copyright © 2016 Dominik Majda. All rights reserved.
//

import Foundation

extension Array {
    
    func randomItem() -> Element? {
        
        if self.count <= 0 {
            return nil
        }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
