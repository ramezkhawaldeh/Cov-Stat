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
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var date: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.getReversedGeoLocation(coordinates: locationManager.location?.coordinate)
    }
    
    private func getDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.date = formatter.string(from: date)
    }
    
    
}

extension CurrentLocationViewController: CLLocationManagerDelegate {
    
       func getReversedGeoLocation(coordinates: CLLocationCoordinate2D?) {
           guard let coordinates = coordinates else {return}
           geoCoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemarks, error in
               if let country = placemarks?.first?.country {
                   self.country = country
                   //self.getCases(date: date, country: country)
                
                self.getCovidCasesData(url: "https://api.covid19tracking.narrativa.com/api/country/Jordan?date_from=2021-05-18&date_to=2021-05-19") { results in
                    
                    if let results = results {
                        print(results)
                    }
                }
               }
           }
       }
}

//MARK: - Networking
extension CurrentLocationViewController {
    
//    func getCases(date: String, country: String) {
//        //"https://api.covid19tracking.narrativa.com/api/\(date)/country/\(country)"
//        if let url = URL(string:"https://api.covid19tracking.narrativa.com/api/2021-05-17/country/\(country)") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error?.localizedDescription as Any)
//                    return
//                }
//
//                self.cases = self.parseJSON(with: data)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.tableView.isHidden = false
//                }
//            }
//            task.resume()
//        }
//    }
//
//    private func parseJSON(with data: Data) -> CovidCases? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(CovidCases.self, from: data)
//            return decodedData
//        } catch {
//            print(error)
//            return nil
//        }
//    }
}


//https://api.covid19tracking.narrativa.com/api/country/Jordan?date_from=2021-05-18&date_to=2021-05-19

