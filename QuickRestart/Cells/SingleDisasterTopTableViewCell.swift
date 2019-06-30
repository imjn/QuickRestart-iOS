//
//  SingleDisasterTopTableViewCell.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit
import MapKit

class SingleDisasterTopTableViewCell: UITableViewCell {

    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var disasterTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView1: UIImageView! {
        didSet {
            imageView1.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var imageView2: UIImageView! {
        didSet {
            imageView2.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var imageView3: UIImageView! {
        didSet {
            imageView3.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var imageView4: UIImageView! {
        didSet {
            imageView4.layer.cornerRadius = 4
        }
    }

    var disaster: Disaster? {
        didSet {
            guard let disaster = disaster else {
                return
            }
            self.mapKitView.delegate = self
            if let latitude = disaster.location?[1], let longitude = disaster.location?.first {
                let point = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                point.title = disaster.labels?.last
                self.mapKitView.addAnnotation(point)
                self.mapKitView.setCenter(point.coordinate, animated: true)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SingleDisasterTopTableViewCell: MKMapViewDelegate {

}
