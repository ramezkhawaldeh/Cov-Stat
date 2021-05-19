//
//  UITableViewCell-Extension.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import Foundation

extension UITableViewCell {

    static var nib: UINib {
        return UINib(nibName: self.dynamicTypeString, bundle: nil)
    }
    
    static var cellIdentifier: String {
        return self.dynamicTypeString
    }
}
