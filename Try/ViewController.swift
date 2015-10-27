//
//  ViewController.swift
//  Try
//
//  Created by Brooke Kanarek on 10/19/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pressed(sender: UIButton) {
        text.text = field.text
        let name = field.text!
      let eventStore = EKEventStore()
        
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {granted, error in
        self.text.text = "fail1"})
        

let calendars = eventStore.calendarsForEntityType(EKEntityType.Event)
for calendar in calendars {
    // 2
    if calendar.title == "Calendar" {
        text.text = field.text! + " added"
        // 3
        let startDate = NSDate()
        // 2 hours
        let endDate = NSDate()
        
        // 4
        // Create Event
        let event = EKEvent(eventStore: eventStore)
        event.calendar = calendar
        
        event.title = name
        event.startDate = startDate
        event.endDate = endDate
        
        // 5
        // Save Event in Calendar
      //  var error: NSError?
        do{
       try eventStore.saveEvent(event, span: EKSpan.ThisEvent)
        }
        catch{
            text.text = "fail2"
        }
        
        
        
        
    }
}
}
}


