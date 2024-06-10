//
//  ContentViewController.swift
//  CareNote
//
//  Created by Batch-1 on 10/06/24.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    
    var image: UIImage?
    var text: String?
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background color of the view to be transparent
        view.backgroundColor = .clear
            
        // Configure imageView
        if let image = image {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
        }

        // Configure textLabel
        if let text = text {
            textLabel.text = text
            textLabel.textAlignment = .center
            textLabel.numberOfLines = 0
            textLabel.translatesAutoresizingMaskIntoConstraints = false
        }

        // Set up layout
        setupLayout()
    }

    private func setupLayout() {
        // Create a container stack view to center the content
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.axis = .vertical
        stackView.alignment = .center // Center content horizontally
        stackView.spacing = 20
            
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        // Center the stack view within the parent view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            // Width constraints for the imageView and stackView to avoid stretching
            imageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.5),

            stackView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
    }
}
