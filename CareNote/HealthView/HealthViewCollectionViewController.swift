//
//  HealthViewCollectionViewController.swift
//  CareNote
//
//  Created by Batch-1 on 29/05/24.
//

import UIKit

class HealthViewCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dataController = DataController.shared
    //Code to make tab bar icon visible
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "doc.text.image")
        super.tabBarItem.selectedImage = UIImage(systemName: "doc.text.image.fill")
    }
    
    @IBOutlet var healthViewCollectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            addGradientBackground()
            
            // Register the XIBs for the cell and header
            healthViewCollectionView.register(UINib(nibName: "CurrentVitalsCell", bundle: nil), forCellWithReuseIdentifier: "CurrentVitalsCell")
            healthViewCollectionView.register(UINib(nibName: "BloodPressureCell", bundle: nil), forCellWithReuseIdentifier: "BloodPressureCell")
            healthViewCollectionView.register(UINib(nibName: "recentReportCell", bundle: nil), forCellWithReuseIdentifier: "recentReportCell")

            // Set up data source and delegate
            healthViewCollectionView.delegate = self
            healthViewCollectionView.dataSource = self
            
            // Set up collection view compositional layout
            healthViewCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
            healthViewCollectionView.backgroundColor = UIColor.clear
            
            // Register the section background view
            healthViewCollectionView.register(SectionBackgroundView.self, forSupplementaryViewOfKind: "SectionBackgroundView", withReuseIdentifier: "SectionBackgroundView")

            healthViewCollectionView.alwaysBounceHorizontal = false
            
            //Set up headers
            healthViewCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        }
    
    //GradientBackground
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let colour1 = UIColor(red: 0x66 / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        let colour2 = UIColor(red: 0x66 / 255.0, green: 0xCC / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        
        gradientLayer.colors = [colour1.cgColor, colour2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                section = self.currentVitalsLayout()
            case 1:
                section = self.lastTestLayout()
            case 2:
                section = self.recentReportLayout()
            default:
                section = self.currentVitalsLayout()
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment:  .top)
            
            // change section background colour
            let sectionBackgroundColour = NSCollectionLayoutDecorationItem.background(elementKind: "SectionBackgroundView")
            section.decorationItems = [sectionBackgroundColour]
            
            section.boundarySupplementaryItems = [header]
            return section
        }
        
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "SectionBackgroundView")
        return layout
    }
        
    //layout for current Vitals
    func currentVitalsLayout() -> NSCollectionLayoutSection {
        // Define the size of the Blood Pressure item (full width)
        let bloodPressureItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(300))
        let bloodPressureItem = NSCollectionLayoutItem(layoutSize: bloodPressureItemSize)
        bloodPressureItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Define the size of the Heart Rate and Blood Sugar items (half width)
        let currentVitalsItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.65))
        let currentVitalsItem = NSCollectionLayoutItem(layoutSize: currentVitalsItemSize)
        currentVitalsItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Create a horizontal group for the Heart Rate and Blood Sugar items
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [currentVitalsItem, currentVitalsItem])
        verticalGroup.interItemSpacing = .fixed(10.0)
        
        // Create a vertical group containing the Blood Pressure item and the nested vertical group
        let mainGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
        let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainGroupSize, subitems: [bloodPressureItem, verticalGroup])
        mainGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Create the section
        let currentVitalsSection = NSCollectionLayoutSection(group: mainGroup)
        currentVitalsSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Return the compositional layout
        return currentVitalsSection
    }
    
    //layout for last test
    func lastTestLayout() -> NSCollectionLayoutSection {
        
        let currentVitalsItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        let currentVitalsItem = NSCollectionLayoutItem(layoutSize: currentVitalsItemSize)
        currentVitalsItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        //Create vertical group
        let lastTestGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let lastTestGroup = NSCollectionLayoutGroup.horizontal(layoutSize: lastTestGroupSize, subitems: [currentVitalsItem,currentVitalsItem])
        lastTestGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        //last test section
        let lastTestSection = NSCollectionLayoutSection(group: lastTestGroup)
        
        lastTestSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return lastTestSection
    }
    
    // layout for recent report
    func recentReportLayout() -> NSCollectionLayoutSection {
        let recentReportItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let recentReportItem = NSCollectionLayoutItem(layoutSize: recentReportItemSize)
        recentReportItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let recentReportGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60)) // need change
        let recentReportGroup = NSCollectionLayoutGroup.vertical(layoutSize: recentReportGroupSize, subitem: recentReportItem, count: 1)
        recentReportGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let recentReportSection = NSCollectionLayoutSection(group: recentReportGroup)
        
        recentReportSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return recentReportSection
    }
    
    // UICollectionViewDataSource methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
}
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
    
            // Configure the header with dummy data
                switch indexPath.section {
                case 0:
                    header.headerLabel.text = "Current Vitals"
                    header.iconButton.isHidden = false
                case 1:
                    header.headerLabel.text = "Last Tests"
                    header.iconButton.isHidden = false
                case 2:
                    header.headerLabel.text = "Recent Report"
                    header.iconButton.isHidden = true
                default:
                    break
                }
                    return header
        }
        fatalError("Unexpected element kind")
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell with dummy data
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BloodPressureCell", for: indexPath) as! BloodPressureCell
                let bpCell = dataController.getMedicalParameter(name: "Blood Pressure")
                cell.titleLabel.text = bpCell?.name
                cell.value1Label.text = "125"
                cell.value2Label.text = "83"
                cell.unitLabel.text = bpCell?.unitOfMeasure
                cell.iconImageView.image = UIImage(systemName: "waveform.path.ecg")
                cell.iconImageView.tintColor = UIColor.systemBlue
                cell.layer.cornerRadius = 8
                return cell
            } else if indexPath.item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let bsCell = dataController.getMedicalParameter(name: "Blood Sugar")
                cell.titleLabel.text = bsCell?.name
                cell.valueLabel.text = bsCell?.getValues().first as? String
                cell.unitLabel.text = bsCell?.unitOfMeasure
                cell.iconImageView.image = UIImage(systemName: "drop")
                cell.iconImageView.tintColor = UIColor.orange
                cell.layer.cornerRadius = 8
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let hrCell = dataController.getMedicalParameter(name: "Heart Rate")
                cell.titleLabel.text = hrCell?.name
                cell.valueLabel.text = hrCell?.getValues().first as? String
                cell.unitLabel.text = hrCell?.unitOfMeasure
                cell.iconImageView.image = UIImage(systemName: "heart")
                cell.iconImageView.tintColor = UIColor.red
                cell.layer.cornerRadius = 8
                return cell
            }
        case 1:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let egfrCell = dataController.getMedicalParameter(name: "eGFR")
                cell.titleLabel.text = egfrCell?.name
                cell.valueLabel.text = egfrCell?.getValues().first as? String
                cell.unitLabel.text = egfrCell?.unitOfMeasure
                cell.iconImageView.image = UIImage(systemName: "chart.bar.doc.horizontal")
                cell.iconImageView.tintColor = UIColor.systemGreen
                cell.layer.cornerRadius = 8
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let crCell = dataController.getMedicalParameter(name: "Creatinine")
                cell.titleLabel.text = crCell?.name
                cell.valueLabel.text = crCell?.getValues().first as? String
                cell.unitLabel.text = crCell?.unitOfMeasure
                cell.iconImageView.image = UIImage(systemName: "cross.vial")
                cell.iconImageView.tintColor = UIColor.purple
                cell.layer.cornerRadius = 8
                return cell
            }
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentReportCell", for: indexPath) as! recentReportCell
            let hgCell = dataController.getMedicalParameter(name: "Haemoglobin")
            cell.titleLabel.text = hgCell?.name
            cell.valueLabel.text = hgCell?.getValues().first as? String
            cell.unitLabel.text = hgCell?.unitOfMeasure
            cell.layer.cornerRadius = 8
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
            return cell
        }
    }
}

