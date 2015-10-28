//
//  Event.swift
//  Events
//
//  Created by Jacqueline Tran on 10/28/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit

class Event {
    // MARK: Properties
    
    var name: String
    
    // MARK: Initialization
    
    init?(name: String) {
        self.name = name
        
        if name.isEmpty {
            return nil
        }
    }
}
