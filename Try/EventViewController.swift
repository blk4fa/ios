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

class EventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Properties
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    // picks the date
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // editable field to add description
    @IBOutlet weak var descriptionField: UITextView!
    // picks calendar
    @IBOutlet weak var calendarPicker: UIPickerView!
    
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
    var desString: String?
    var chosenDate: NSDate?
    
    // starts the calendar picker with this phrase
    var pickerDataSource = ["Choose a Calendar"]
 //   var photo: UIImage?
    
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
        
        //keep the values the same for each
        if desString != nil{
            descriptionField.text = desString
        }
        
        if chosenDate != nil {
          datePicker.date = chosenDate!
        }
        
        //stuff the tutorial says I need to set up the picker
        self.calendarPicker.dataSource = self
        self.calendarPicker.delegate = self
        
        //gets the calendars from the calednar app adds them to the picker
        let eventStore2 = EKEventStore()
        eventStore2.requestAccessToEntityType(EKEntityType.Event, completion: {granted, error in
            /*self.text.text = */"fail1"})
        let calendars2 = eventStore2.calendarsForEntityType(EKEntityType.Event)
        
        for c in calendars2 {
            //adds the calendars to the  picker
            pickerDataSource.append(c.title)
        }
        
        
  //      if photo != nil{
    //     photoImageView.image = photo
      //  }
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = field.text ?? ""
            
            // Set the event to be passed to EventTableViewController after the unwind segue.
            event = Event(name: name)
            
            event!.name = name
          event!.descript = descriptionField.text
            
            if xCoord == nil{
            xCoord = 0
            }
            
            if yCoord == nil{
            yCoord = 0
            }
            
            event!.x = xCoord
            event!.y = yCoord
            
            // some code that gets the date and the date components
            let date = datePicker.date
            let calendar = NSCalendar.currentCalendar()
            let unitFlags: NSCalendarUnit = [.Hour, .Day, .Month, .Year, .Minute]
            let components = calendar.components(unitFlags, fromDate: date)
            
            let dateYear =  components.year
            let dateMonth = components.month
            let dateDay = components.day
            let dateHour = components.hour
            
        }
        
        if (segue.identifier == "locationSegue") {
            let navvc = segue.destinationViewController as! UINavigationController;
            let svc = navvc.viewControllers.first as! MapViewController
            svc.name = field.text
            svc.comment = text.text
            svc.descrip = descriptionField.text
            svc.date = datePicker.date
    //        svc.pic = photoImageView.image
        }

    }
    
    
    //three functions the tutorial says I need for the picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
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
    
    // this is connected to the new done button, currently the way to close the keyboard after you type the description
    @IBAction func hideKeyBoardDes(sender: AnyObject) {
        descriptionField.resignFirstResponder()
    }
    // MARK: Actions
    
    /*func imagePickerControllerDidCancel(picker: UIImagePickerController) {
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
    }*/
    
    

    @IBAction func pressed(sender: UIButton) {
        
        text.text = field.text
        let name = field.text!
        let eventStore = EKEventStore()
        
        // ensure that the calendar picker isn't set to the first choice
        if calendarPicker.selectedRowInComponent(0) != 0 {
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {granted, error in
        /*self.text.text =*/ "fail1"})
        

let calendars = eventStore.calendarsForEntityType(EKEntityType.Event)
for calendar in calendars {
    
    //gets the calendar that the picker is on
    if calendar.title == calendars[calendarPicker.selectedRowInComponent(0) - 1].title {
        text.text = field.text! + " added to calendar"
        // 3
        let startDate = datePicker.date        // 2 hours
        let endDate = datePicker.date
        
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
            // sets the text to this if the first option in the picker is still set
        else {
            self.text.text = "Please choose a Calendar"
        }

        }
    }



