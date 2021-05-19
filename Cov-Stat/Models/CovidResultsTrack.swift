//
//  CovidResultsTrack.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation

struct CovidResult: Codable {
    let dates: [String : Countries]
    let total: TotalCases
}

struct Countries: Codable {
    let countries: [String : CountryStatus]
}

struct CountryStatus: Codable {
    let today_confirmed: Double
    let today_deaths: Double
    let today_new_confirmed: Double
    let today_new_deaths: Double
    let today_new_open_cases: Double
    let today_new_recovered: Double
    let today_open_cases: Double
    let today_recovered: Double
    let today_vs_yesterday_confirmed: Double
    let today_vs_yesterday_deaths: Double
    let today_vs_yesterday_open_cases: Double
    let today_vs_yesterday_recovered: Double
    let yesterday_confirmed: Double
    let yesterday_deaths: Double
    let yesterday_open_cases: Double
    let yesterday_recovered: Double
}

struct TotalCases: Codable {
    let today_confirmed: Double
    let today_deaths: Double
    let today_new_confirmed: Double
    let today_new_deaths: Double
    let today_new_open_cases: Double
    let today_new_recovered: Double
    let today_open_cases: Double
    let today_recovered: Double
    let today_vs_yesterday_confirmed: Double
    let today_vs_yesterday_deaths: Double
    let today_vs_yesterday_open_cases: Double
    let today_vs_yesterday_recovered: Double
    let yesterday_confirmed: Double
    let yesterday_deaths: Double
    let yesterday_open_cases: Double
    let yesterday_recovered: Double
}

struct CovidCountriesList: Codable {
    let countries: [CovidCountryDetails]
}

struct CovidCountryDetails: Codable {
    let id: String?
    let name: String?
}
//https://api.covid19tracking.narrativa.com/api/countries
