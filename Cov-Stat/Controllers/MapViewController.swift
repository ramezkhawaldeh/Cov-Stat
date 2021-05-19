//
//  MapViewController.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
     @IBOutlet var mapView: MKMapView!
     var locationManager = CLLocationManager()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         //mapView.isHidden = true
         
     }
     
 }

 //MARK: - Map Delegate
 extension MapViewController: MKMapViewDelegate {
     
 }

 //MARK: - Networking
 extension MapViewController {
     
 }
