//
//  MapViewController.swift
//  Events
//
//  Created by Brooke Kanarek on 11/3/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

//
//  MapViewController.swift
//  Events
//
//  Created by Brooke Kanarek on 11/2/15.
//  Copyright © 2015 Brooke Kanarek. All rights reserved.
//

import UIKit
import EventKit
import CoreLocation
import MapKit


class MapViewController: UIViewController,CLLocationManagerDelegate {
    let point = MKPointAnnotation()
    
    var locationManager: CLLocationManager!
    var xC: Double!
    var yC: Double!
    var start: Bool!
    var name: String!
    var comment: String!
    
    //new stuff to maintain info
    var date: NSDate!
    
    //var pic: UIImage!
    
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
    }
    
    @IBAction func chooseLocation(sender: AnyObject) {
        let location = sender.locationInView(mapView)
        let locCoord = self.mapView.convertPoint(location, toCoordinateFromView:self.mapView  )
        xC = locCoord.latitude
        yC = locCoord.longitude
        
        
        point.coordinate = locCoord
        point.title = name
        mapView.addAnnotation(point)
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "saveLocation") {
            let svc = segue.destinationViewController as! EventViewController
            svc.xCoord = xC
            svc.yCoord = yC
            svc.eventName = name
            svc.labelString = comment
            //new stuff to maintain info
            svc.chosenDate = date
            //    svc.photo = pic
            
        }

    }
    
}