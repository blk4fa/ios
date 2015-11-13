//
//  Event.swift
//  Events
//
//  Created by Jacqueline Tran on 10/28/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var descript: String?
    var x: NSNumber?
    var y: NSNumber?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
    }
    
    // MARK: Initialization
    
    init?(name: String) {
        self.name = name
        
        super.init()
        
        if name.isEmpty {
            return nil
        }
    }
    
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Event, use conditional cast.
        //let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        // Must call designated initilizer.
        self.init(name: name)
    }
}
