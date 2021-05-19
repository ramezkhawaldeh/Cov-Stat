//
//  CovidMapCity.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation
import MapKit

class CovidMapCity: NSObject, MKAnnotation {
    var countryName: String?
    var coordinate: CLLocationCoordinate2D
    var numberOfCases: String?

    init(name: String, coordinate: CLLocationCoordinate2D, numberOfCases: String?) {
        self.countryName = name
        self.coordinate = coordinate
        self.numberOfCases = numberOfCases
    }
}
