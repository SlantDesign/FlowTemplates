//
//  DataSource.swift
//  RefreshControl
//
//  Created by Travis on 2021-11-12.
//

import UIKit
import Foundation

class DataSource: NSObject, UITableViewDataSource {
    struct Defaults {
        static let rowCount = 20
        static let cellIdentifier = "dataSourceCell"
    }

    let allData = ["I'm baby pork belly",
                "Put a bird on it",
                "Tofu street art",
                "Austin blog man bun",
                "Everyday carry",
                "Farm-to-table",
                "Direct trade williamsburg",
                "Hoodie crucifix",
                "Wolf bushwick",
                "Vinegar aesthetic",
                "Deep v semiotics",
                "Single-origin pabst",
                "Coffee microdosing",
                "Messenger bag brunch",
                "Green juice",
                "Ugh heirloom",
                "Chillwave organic",
                "Man bun salvia",
                "Vaporware",
                "Tbh flexitarian",
                "Franzen skateboard",
                "Echo park cardigan",
                "Vegan art party",
                "Mumblecore hoodie",
                "Roof party banjo",
                "Wayfarers master cleanse",
                "YOLO hexagon",
                "Chicharrones messenger",
                "Adaptogen copper mug",
                "Forage 8-bit",
                "Bicycle rights",
                "Asymmetrical",
                "Disrupt gastropub",
                "Woke fingerstache",
                "Man braid biodiesel",
                "Artisan air plant",
                "Bespoke taiyaki",
                "Shabby chic"]

    var currentData = [String]()

    override init() {
        super.init()
        updateData()
    }

    func updateData() {
        currentData = randomData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataSource.Defaults.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: DataSource.Defaults.cellIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: DataSource.Defaults.cellIdentifier)
        cell.backgroundColor = UIColor.lightGray
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 10
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = currentData[indexPath.row]
        return cell
    }

    func randomData() -> [String] {
        var mutable = allData
        var dataArray = [String]()
        for _ in 0..<DataSource.Defaults.rowCount {
            let index = Int.random(in: 0..<mutable.count)
            dataArray.append(mutable.remove(at: index))
        }
        return dataArray
    }
}
