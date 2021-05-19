//
//  UIViewController-Extension.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation
import UIKit
import SVGKit

extension UIViewController {
    
    func getCovidCasesData(url: String, completion: @escaping (CovidResult?) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                let cases: CovidResult?
                guard let data = data, error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }
                cases = self.parseCovidCasesJSON(with: data)
                completion(cases)
            }
            task.resume()
        }
    }
    
    func parseCovidCasesJSON(with data: Data) -> CovidResult? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CovidResult.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}

extension UIViewController {
    
    func getCountryFlagAndCoordinates(url: String, completion: @escaping (Country?) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                let country: Country?
                guard let data = data, error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                country = self.parseCountryFlagJSON(with: data)
                completion(country)
            }
            task.resume()
        }
    }
    
    private func parseCountryFlagJSON(with data: Data) -> Country? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Country].self, from: data)
            return decodedData.first
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func getSVGImage(from string: String) -> UIImage? {
        var flagImage: UIImage? = nil
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url, options: [])
            let flagSVGImage: SVGKImage = SVGKImage(data: data)
            flagImage = flagSVGImage.uiImage
        }
        catch {
            print(error.localizedDescription)
        }
        return flagImage
    }
    
    func getNewsData(country: String, completionHandler: @escaping (News?) -> Void) {
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?\(country)&category=\(NewsCategory.health)&apiKey=\(APIKey.news.rawValue)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                let news: News?
                guard let data = data, error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                news = self?.parseNewsJSON(with: data)
                completionHandler(news)
            }
            task.resume()
        }
    }
    
    private func parseNewsJSON(with data: Data) -> News? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(News.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
    func getCovidCountiresList(completion: @escaping (CovidCountriesList?) -> Void) {
        guard let url = URL(string: "https://api.covid19tracking.narrativa.com/api/countries") else { return }
        let session = URLSession(configuration: .default)
        var countriesList: CovidCountriesList?
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                return
            }
            countriesList = self?.parseCovidCountiresJSON(with: data)
            completion(countriesList)
        }
        task.resume()
    }
    
    private func parseCovidCountiresJSON(with data: Data) -> CovidCountriesList? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CovidCountriesList.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}
