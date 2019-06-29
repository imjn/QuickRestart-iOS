//
//  CertificateListViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit

class CertificateListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CertificateTableViewCell", bundle: nil), forCellReuseIdentifier: "CertificateCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CertificateListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CertificateCell", for: indexPath) as? CertificateTableViewCell else { return UITableViewCell() }
        return cell
    }
}
