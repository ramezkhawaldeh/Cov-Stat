//
//  CurrentLocationViewController.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import UIKit
import CoreLocation
import MapKit

class CurrentLocationViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var country: String?
    var currentCountryCode: String?
    var today, yesterday: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.flagImageView.isHidden = true
        
        self.tabBarController?.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.getReversedGeoLocation(coordinates: locationManager.location?.coordinate)
        
    }
    
    private func getDate() -> (String, String){
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return ((formatter.string(from: today)),(formatter.string(from: yesterday!)))
    
    
}
}

extension CurrentLocationViewController: CLLocationManagerDelegate {
    
    func getReversedGeoLocation(coordinates: CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else {return}
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        today = self.getDate().0
        yesterday = self.getDate().1
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemarks, error in
            if let country = placemarks?.first?.country {
                self.country = country
                self.getCovidCasesData(url: "https://api.covid19tracking.narrativa.com/api/country/\(country)?date_from=\(self.yesterday!)&date_to=\(self.today!)") { results in
                    
                    if let results = results {
                        self.getCountryFlag(url: "https://restcountries.eu/rest/v2/name/\(country)?fields=name;flag;alpha2Code") {
                            country in
                            if let country = country {
                                self.currentCountryCode = country.alpha2Code
                                DispatchQueue.main.async {
                                    self.flagImageView.image = self.getSVGImage(from: country.flag)
                                }
                            }
                        }
                        print(results)
                    } else {
                        
                    }
                    DispatchQueue.main.async {
                        self.flagImageView.isHidden = false
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}

//MARK: - Networking
extension CurrentLocationViewController {
    
}


//https://api.covid19tracking.narrativa.com/api/country/Jordan?date_from=2021-05-18&date_to=2021-05-19

