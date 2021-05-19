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
    var countriesList: CovidCountriesList?
    var cities = [CovidMapCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestLocation()
        
       mapView.isHidden = true
        
        self.getCovidCountiresList { list in
            if let list = list {
                self.countriesList = list
               // self.
            }
        }
        print(self.countriesList)
        self.tabBarController?.delegate = self
    }

    
}

//MARK: - Map Delegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CovidMapCity else { return nil }
        let reuseIdentifier = "City"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                annotationView?.canShowCallout = true
                annotationView?.image = #imageLiteral(resourceName: "sick")
                let button = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = button
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? CovidMapCity else { return }
        let countryName = capital.countryName
        let numberOfCases = capital.numberOfCases
        let ac = UIAlertController(title: countryName, message: numberOfCases, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Do you want the latest news?", style: .destructive))
        present(ac, animated: true)
    }
    
}

//MARK: - Networking
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 50,
                                            longitudinalMeters: 50)
            mapView.setRegion(region, animated: true)
            //mapView.addAnnotations(annotations)
            mapView.isHidden = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: UITabBarControllerDelegate {
    
}
