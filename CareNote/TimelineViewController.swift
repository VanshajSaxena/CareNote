//
//  TimelineViewController.swift
//  CareNote
//
//  Created by Batch-2 on 03/06/24.
//

import UIKit

class TimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dataController = DataController.shared
    
    @IBOutlet var timelineCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TimelineCollectionViewCell", bundle: nil)
        timelineCollectionView.register(nib, forCellWithReuseIdentifier: "TimelineCollectionViewCell")
        
        // Set the data source and delegate
        timelineCollectionView.dataSource = self
        timelineCollectionView.delegate = self
        
        // Assign the custom layout to the collection view
        timelineCollectionView.collectionViewLayout = createCompositionalLayout()
        timelineCollectionView.backgroundColor = UIColor.clear
        
        addGradientBackground()
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let colour1 = UIColor(red: 0x66 / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        let colour2 = UIColor(red: 0x66 / 255.0, green: 0xCC / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        
        gradientLayer.colors = [colour1.cgColor, colour2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Register the custom cell
        
    }
    
    // Create the custom compositional layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.timelineLayout()
        }
        
        // Register the section background view
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "SectionBackgroundView")
        
        return layout
    }
    
    func timelineLayout() -> NSCollectionLayoutSection {
        let timelineItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(190))
        let timelineItem = NSCollectionLayoutItem(layoutSize: timelineItemSize)
        timelineItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let timelineGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(400))
        let timelineGroup = NSCollectionLayoutGroup.vertical(layoutSize: timelineGroupSize, subitem: timelineItem, count: 2)
        timelineGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let timelineSection = NSCollectionLayoutSection(group: timelineGroup)
        timelineSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "SectionBackgroundView")
        timelineSection.decorationItems = [sectionBackground]
        
        return timelineSection
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimelineCollectionViewCell", for: indexPath) as! TimelineCollectionViewCell
        
        // Configure the cell with sample data
        cell.configureCell(date: "12", month: "May", title: "Dr. Subodh", description: "Pain in Bladder", notes: "Urinary Tract Infection", nextAppointmentDate: "15 June")
        
        cell.layer.cornerRadius = 8
        
        return cell
    }
}
