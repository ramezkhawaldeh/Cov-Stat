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
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isHidden = true
        self.flagImageView.isHidden = true
        self.flagImageView.layer.borderWidth = 4
        self.flagImageView.layer.borderColor = UIColor(named: "Image-Border")?.cgColor
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
                self.getCovidCasesData(url: "https://api.covid19tracking.narrativa.com/api/country/\(country)?date_from=\(self.yesterday!)&date_to=\(self.today!)") { [weak self] results in
                    if let results = results {
                        self?.getCountryFlagAndCoordinates(url: "https://restcountries.eu/rest/v2/name/\(country)?fields=name;flag;alpha2Code;latlng") {
                            country in
                            if let country = country {
                                self?.currentCountryCode = country.alpha2Code
                                DispatchQueue.main.async {
                                    self?.flagImageView.image = self?.getSVGImage(from: country.flag)
                                }
                            }
                        }
                        self?.getNewsData(country: country) { [weak self] news in
                            if let news = news {
                                self?.news = news
                            }
                        }
                        print(results)
                    } else {
                        
                    }
                    DispatchQueue.main.async {
                        self?.flagImageView.isHidden = false
                        self?.activityIndicator.stopAnimating()
                        self?.tableView.reloadData()
                        self?.tableView.isHidden = false
                    }
                }
            }
        }
    }
}

//MARK: - News TableView delegate
extension CurrentLocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = self.news else {return 0}
        return news.totalResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let news = self.news else { return UITableViewCell() }
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillDate(with: news.articles[indexPath.row])
        return cell
    }
}


