//
//  StatusViewController.swift
//  Cov-Stat
//
//  Created by Ramez Khawaldeh on 19/05/2021.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var statistics: CovidResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(CovidCasesTableViewCell.self)
    }
}

extension StatusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CovidCasesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let data = self.statistics else {
            return UITableViewCell()
        }
        cell.fill(with: data)
        return cell
    }
}
