//
//  EventViewController.swift
//  Try
//
//  Created by Brooke Kanarek on 10/19/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class EventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
    This value is either passed by `EventTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new event.
    */
    var event: Event?
    
    var xCoord: Double?
    var yCoord: Double?
    
    var eventName: String?
    var labelString: String?
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        field.delegate = self
        
        if eventName != nil{
            field.text = eventName
        }
        
        if labelString != nil{
            text.text = labelString! + " added"
        }
        if photo != nil{
         photoImageView.image = photo
        }
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = text.text ?? ""
            
            // Set the event to be passed to EventTableViewController after the unwind segue.
            event = Event(name: name)
            
            event!.name = name
          event!.descript = "this is working"
            
            if xCoord == nil{
            xCoord = 0
            }
            
            if yCoord == nil{
            yCoord = 0
            }
            
            event!.x = xCoord
            event!.y = yCoord
            
        }
        
        if (segue.identifier == "locationSegue") {
            let navvc = segue.destinationViewController as! UINavigationController;
            let svc = navvc.viewControllers.first as! MapViewController
            svc.name = field.text
            svc.comment = text.text
            svc.pic = photoImageView.image
        }

    }
    
    
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        field.text = textField.text
    }
    
    
    // MARK: Actions
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        text.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
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
    if calendar.title == "Home" {
        text.text = field.text!
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


