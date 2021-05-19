//
//  CountryFlagData.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation

struct CountryFlagData {
    
    let flag: String?
    let name: String?
    let alpha3Code: String?
    let alpha2Code: String?
    let latlng: [Double]?
    
    init(_ data: [String: Any]) {
        self.flag = data["flag"] as? String
        self.name = data["name"] as? String
        self.alpha2Code = data["alpha2Code"] as? String
        self.alpha3Code = data["alpha3Code"] as? String
        self.latlng = data["latlng"] as? [Double]
    }
}

struct Country: Codable {
    let flag: String
    let name: String
    let alpha2Code: String
}
