//
//  MapKit.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/23/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapKit: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    var locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        view.addSubview(mapView)
        
        
        
        
        _ = mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)

       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    

  

}
