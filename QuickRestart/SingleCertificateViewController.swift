//
//  SingleCertificateViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import AloeStackView
import UIKit

public class SingleCertificateViewController: AloeStackViewController {

    // MARK: Public

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpSelf()
        setUpStackView()
    }

    var certificate: Certificate!

    // MARK: Private

    private func setUpSelf() {
        title = "AloeStackView Example"
    }

    private func setUpStackView() {
        stackView.automaticallyHidesLastSeparator = true
    }

}
