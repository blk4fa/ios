//
//  EventCategoriesViewController.swift
//  Events
//
//  Created by Jacqueline Tran on 11/14/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit

class EventCategoriesViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var availableButton: UIButton!
    @IBOutlet weak var scheduledButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    
    var eventsCategory: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if availableButton === sender {
            eventsCategory = "available"
        }
        else if scheduledButton === sender {
            eventsCategory = "scheduled"
        }
        else {
            eventsCategory = "past"
        }
        
        if (segue.identifier == "availableSegue") {
            let vc = segue.destinationViewController as! EventTableViewController
            vc.eventsCategory = eventsCategory
        }
    }

}
