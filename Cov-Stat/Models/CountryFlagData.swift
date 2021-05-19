//
//  Country.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation

struct Country: Codable {
    let flag: String
    let name: String
    let alpha2Code: String
    let latlng: [Double]
}


