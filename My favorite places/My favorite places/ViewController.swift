//
//  ViewController.swift
//  My favorite places
//
//  Created by Yuen Hsi Chang on 7/22/15.
//  Copyright (c) 2015 yg. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var actionHandler = UILongPressGestureRecognizer(target: self, action: "action:")
        actionHandler.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(actionHandler)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var location:CLLocation = locations[0] as! CLLocation
        var latitude = location.coordinate.latitude
        var longtitude = location.coordinate.longitude
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees  = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var centerLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(centerLocation, span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var selectedPoint = gestureRecognizer.locationInView(mapView)
            var selectedCoordinate:CLLocationCoordinate2D = mapView.convertPoint(selectedPoint, toCoordinateFromView: mapView)
            var annotation = MKPointAnnotation()
            annotation.coordinate = selectedCoordinate
            
            mapView.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

