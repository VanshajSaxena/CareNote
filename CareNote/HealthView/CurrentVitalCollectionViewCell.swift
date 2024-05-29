//
//  CurrentVitalCollectionViewCell.swift
//  CareNote
//
//  Created by Batch-1 on 29/05/24.
//

import UIKit

class CurrentVitalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 20
    }
}
