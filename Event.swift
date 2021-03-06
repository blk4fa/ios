//
//  Event.swift
//  Events
//
//  Created by Jacqueline Tran on 11/2/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import Foundation

    // Insert code here to add functionality to your managed object subclass
//    @NSManaged var name: String?
//    @NSManaged var descript: String?
//    @NSManaged var x: NSNumber?
//    @NSManaged var y: NSNumber?

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
        static let descriptKey = "descript"
        static let xKey =  "x"
        static let yKey = "y"
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
