//
//  EventMapController.swift
//  Events
//
//  Created by Brooke Kanarek on 11/3/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit
import EventKit
import CoreLocation
import MapKit
import CoreData

class EventMapController: UIViewController,CLLocationManagerDelegate {
    var events = [Event]()
    var locationManager: CLLocationManager!
    var xC: Double!
    var yC: Double!
    var start: Bool!
    var name: String!
   
    
    @IBOutlet weak var mapView: MKMapView!
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count == 0{
            //handle error here
            return
        }
        
        let newLocation = locations[0]
        
        print("Latitude = \(newLocation.coordinate.latitude)")
        print("Longitude = \(newLocation.coordinate.longitude)")
        xC = newLocation.coordinate.latitude
        yC = newLocation.coordinate.longitude
        
        
        if(start == true)
        {
            let coor = CLLocationCoordinate2DMake(xC, yC)
            let span = MKCoordinateSpanMake(0.005,0.005);
            
            
            let viewRegion = MKCoordinateRegionMake(coor, span)
            mapView.setRegion(viewRegion, animated: false)
            start = false
        }
        
        
        
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError){
            print("Location manager failed with error = \(error)")
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                print("Authorized")
            case .AuthorizedWhenInUse:
                print("Authorized when in use")
            case .Denied:
                print("Denied")
            case .NotDetermined:
                print("Not determined")
            case .Restricted:
                print("Restricted")
            }
            
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func createLocationManager(startImmediately startImmediately: Bool){
        locationManager = CLLocationManager()
        if let manager = locationManager{
            print("Successfully created the location manager")
            manager.delegate = self
            if startImmediately{
                manager.startUpdatingLocation()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .AuthorizedWhenInUse:
                /* Yes, only when our app is in use */
                createLocationManager(startImmediately: true)
            case .Denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .NotDetermined:
                /* We don't know yet, we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
                
            case .Restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            }
            
            
        } else
        {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            print("Location services are not enabled")
        }
        start = true;
        
        // Load any saved events
        if let savedEvents = loadEvents() {
            events += savedEvents
        }
        
        for e: Event in events{
        let point = MKPointAnnotation()
        let locCoord = CLLocationCoordinate2DMake(e.x!.doubleValue, e.y!.doubleValue)
        point.coordinate = locCoord
        point.title = e.name
        mapView.addAnnotation(point)
        }
        
    }
    
    
    // MARK: NSCoding
    
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save events...")
        }
    }
    
    func loadEvents() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
    }
    
   /* override func viewWillLayoutSubviews() {
        
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight {
            
            var rect = mapView.frame
            rect.origin.x = 294
            rect.size.width = 254
            rect.size.height = 130
            mapView.frame = rect
            
           /* rect = topRightView.frame
            
            rect.size.width = 254
            rect.size.height = 130
            topRightView.frame = rect
            
            rect = bottomView.frame
            rect.origin.y = 170
            rect.size.width = 528
            rect.size.height = 130
            bottomView.frame = rect
           */
        } else {
            
            var rect = mapView.frame
            rect.origin.x = 294
            rect.size.width = 130
            rect.size.height = 254
            mapView.frame = rect
            
          /*  rect = topRightView.frame
            rect.origin.x = 170
            rect.size.width = 130
            rect.size.height = 254
            topRightView.frame = rect
            
            rect = bottomView.frame
            rect.origin.y = 295
            rect.size.width = 280
            rect.size.height = 254
            bottomView.frame = rect
*/
}
    }*/
}