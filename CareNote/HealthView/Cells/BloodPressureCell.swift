//
//  BloodPressureCell.swift
//  CareNote
//
//  Created by Batch-1 on 30/05/24.
//

import Foundation

import UIKit

class BloodPressureCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var unitLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var value1Label: UILabel!
    @IBOutlet var value2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
