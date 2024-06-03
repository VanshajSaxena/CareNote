//
//  SectionBackgroundView.swift
//  CareNote
//
//  Created by Batch-1 on 31/05/24.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
            super.init(frame: frame)
            self.layer.cornerRadius = 10
        self.backgroundColor = .white.withAlphaComponent(0.2)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
}
