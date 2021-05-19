//
//  CovidCasesTableViewCell.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import UIKit

class CovidCasesTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet var infctedLabel: UILabel!
    @IBOutlet var passedAwayLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    
    
    func fill(with data: CovidResult) {
        self.infctedLabel.text = "\((data.dates.first?.value.countries.first?.value.today_open_cases)! as Double)"
        self.recoveredLabel.text = "\((data.dates.first?.value.countries.first?.value.today_new_recovered)! as Double)"
        self.passedAwayLabel.text = "\((data.dates.first?.value.countries.first?.value.today_new_deaths)! as Double)"
    }
}
