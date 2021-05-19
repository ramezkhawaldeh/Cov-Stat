//
//  CovidData.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation

struct CovidData: Codable {
    let country: String?
    let countryInfo: CountryInfo
    let cases: Double?
    let deaths: Double?
    let recovered: Double?
    let active: Double?
    let critical: Double?
}

struct CountryInfo: Codable {
    let iso2: String?
    let lat: Double?
    let long: Double?
    let flag: String?
}
