//
//  Event.swift
//  Events
//
//  Created by Jacqueline Tran on 11/2/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import Foundation
import CoreData

@objc(Event) class Event: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    @NSManaged var name: String?
    @NSManaged var descript: String?
    @NSManaged var x: NSNumber?
    @NSManaged var y: NSNumber?

}
