//
//  MapViewController.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import UIKit
import MapKit
import CoreLocation
  
class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var countriesList: CovidCountriesList?
    var cities = [CovidMapCity]()
    
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.tabBarController?.delegate = self
        mapView.delegate = self
        
        addCustomAnnotation(title: "Hello", subtitle: ":)")
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
    }
}

//MARK: - Map Delegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotaionView == nil {
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotaionView?.canShowCallout = true
            annotaionView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotaionView?.annotation = annotation
        }
        
        annotaionView?.image = UIImage(named: "sick")
        return annotaionView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       
    }

    private func addCustomAnnotation(title: String, subtitle: String) {
         let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
        annotation.coordinate = CLLocationCoordinate2D(latitude: 33, longitude: -47)
    }
    
}

//MARK: - Networking
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: UITabBarControllerDelegate {
    
}

extension MapViewController {
    
//    private func fetchAllCountries(completion: @escaping ([CovidData]) -> Void) {
//        if let url = URL(string: "https://corona.lmao.ninja/v2/countries?yesterday") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                let country: [CovidData]
//                guard let data = data, error == nil else {
//                    print(error?.localizedDescription)
//                    return
//                }
//                country = self.parseAllCountriesJSON(with: data)
//                completion(country)
//            }
//            task.resume()
//        }
//    }
    
//    private func parseAllCountriesJSON(with data: Data) -> [CovidData] {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode([CovidData].self, from: data)
//            return decodedData
//        }
//        catch {
//            print(error)
//            return []
//        }
//    }
}

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
