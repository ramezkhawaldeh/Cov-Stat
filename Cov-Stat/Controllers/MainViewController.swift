//
//  MainViewController.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
}

//MARK: - Map Delegate
extension MainViewController: MKMapViewDelegate {
    
}

//MARK: - Networking
extension MainViewController {
    
}
