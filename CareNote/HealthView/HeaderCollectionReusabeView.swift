//
//  HeaderCollectionReusabeView.swift
//  CareNote
//
//  Created by Batch-1 on 31/05/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeader()
    }
    
    private func setupHeader() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        //secondLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
