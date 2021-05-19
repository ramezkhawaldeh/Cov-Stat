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
    
     func getCountryFlag(url: String, completion: @escaping (Country?) -> Void) {
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
}
