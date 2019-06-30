//
//  SingleDisasterViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit
import MapKit

class SingleDisasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var disaster: Disaster!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SingleDisasterTopTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleDisasterTopCell")
    }

}

extension SingleDisasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleDisasterTopCell", for: indexPath) as? SingleDisasterTopTableViewCell else { return UITableViewCell() }
        cell.disaster = disaster
        cell.disasterTitleLabel.text = disaster.title
        cell.contentTextView.text = disaster.content
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .long
        cell.dateLabel.text = f.string(from: disaster.date)
        return cell
    }

}

extension SingleDisasterViewController: MKMapViewDelegate {

}
