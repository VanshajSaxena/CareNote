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
    
    @IBOutlet var recentZone1: UIImageView!
    @IBOutlet var recentZone2: UIImageView!
    @IBOutlet var recentZone3: UIImageView!
    @IBOutlet var recentZone4: UIImageView!
    @IBOutlet var recentZone5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
