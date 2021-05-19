//
//  NSObject-Extension.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation

extension NSObject {

    static var dynamicTypeString: String {
        let string = String(describing: type(of: self.classForCoder()))
        return string.components(separatedBy: ".").first ?? string
    }
}
