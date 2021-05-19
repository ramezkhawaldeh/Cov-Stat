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
    
    var allCountries: [CovidData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.tabBarController?.delegate = self
        //mapView.isHidden = true
        
        self.fetchAllCountries { country in
            self.allCountries = country
        }
        
//        self.getCovidCountiresList { list in
//
//            if let list = list {
//                self.countriesList = list
//                list.countries.forEach { country in
//                    DispatchQueue.main.async {
//                        self.getCountryFlagAndCoordinates(url:"https://restcountries.eu/rest/v2/name/\(country.name!)?fields=name;flag;alpha2Code;latlng" ) { city in
//                            if let cityName = city?.name, let coordinate = city?.latlng {
//                                self.cities.append(CovidMapCity(name: cityName, coordinate: CLLocationCoordinate2D(latitude: coordinate[0], longitude: coordinate[1]), numberOfCases: nil))
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
}

//MARK: - Map Delegate
extension MapViewController: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//    }
//    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//       
//    }
//    
}

//MARK: - Networking
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = self.allCountries.first {
            let region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: location.countryInfo.lat!, longitude: location.countryInfo.long!) ,
                                            latitudinalMeters: 50,
                                            longitudinalMeters: 50)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
            ///mapView.addAnnotations(annotations)
            mapView.isHidden = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: UITabBarControllerDelegate {
    
}

extension MapViewController {
    
    private func fetchAllCountries(completion: @escaping ([CovidData]) -> Void) {
        if let url = URL(string: "https://corona.lmao.ninja/v2/countries?yesterday") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                let country: [CovidData]
                guard let data = data, error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                country = self.parseAllCountriesJSON(with: data)
                completion(country)
            }
            task.resume()
        }
    }
    
    private func parseAllCountriesJSON(with data: Data) -> [CovidData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CovidData].self, from: data)
            return decodedData
        }
        catch {
            print(error)
            return []
        }
    }
}
