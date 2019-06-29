//
//  ViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit
import CoreLocation

class EearthQuakeListViewController: UIViewController {

    var locationManager: CLLocationManager!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "DisasterTableViewCell", bundle: nil), forCellReuseIdentifier: "DisasterCell")

        setupLocationManager()

    }

    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }

        locationManager.requestWhenInUseAuthorization()

        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }

}

extension  EearthQuakeListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DisasterCell", for: indexPath) as? DisasterTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension EearthQuakeListViewController: CLLocationManagerDelegate {
    
}
