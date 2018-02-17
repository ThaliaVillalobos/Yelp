//
//  MapViewController.swift
//  Yelp
//
//  Created by Thalia Villalobos on 2/16/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var business: Business!
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let address = business.address{
            //print("Here: " + address)
            self.address = address
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) {
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let lon = placemark?.location?.coordinate.longitude
                //print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
                
                let centerlocation = CLLocation(latitude: lat!, longitude: lon!)
                self.goToLocation(location: centerlocation)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
        addAnnotationAtAddress(address: self.address, title: business.name!)
    }
    

    
    // add an annotation with an address: String
    func addAnnotationAtAddress(address: String, title: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }

}
