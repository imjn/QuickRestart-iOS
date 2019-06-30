//
//  DisasterTableViewCell.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit

class DisasterTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var gradationImageView: UIImageView! {
        didSet {
            gradationImageView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var fadeView: UIView! {
        didSet {
            fadeView.layer.cornerRadius = 4
        }
    }

    @IBOutlet weak var disasterTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
