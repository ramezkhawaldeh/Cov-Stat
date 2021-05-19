//
//  UIViewController-Extension.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation
import UIKit

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
//                self.cases = self.parseJSON(with: data)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.tableView.isHidden = false
//                }
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
