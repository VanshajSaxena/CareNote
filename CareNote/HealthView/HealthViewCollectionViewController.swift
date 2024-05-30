//
//  HealthViewCollectionViewController.swift
//  CareNote
//
//  Created by Batch-1 on 29/05/24.
//

import UIKit

class HealthViewCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Code to make tab bar icon visible
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "doc.text.image")
        super.tabBarItem.selectedImage = UIImage(systemName: "doc.text.image.fill")
    }
    
    @IBOutlet var healthViewCollectionView: UICollectionView!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Register the XIBs for the cell and header
//        healthViewCollectionView.register(UINib(nibName: "CurrentVitalsCell", bundle: nil), forCellWithReuseIdentifier: "CurrentVitalsCell")
//        healthViewCollectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
//               
//        // Set up data source and delegate
//        healthViewCollectionView.dataSource = self
//        healthViewCollectionView.delegate = self
//               
//        // Configure the compositional layout
//        healthViewCollectionView.collectionViewLayout = createLayout()
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//            return 3
//        }
//        
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1 // Recent Report
//        case 1:
//            return 2 // Last Tests
//        case 2:
//            return 3 // Current Vitals
//        default:
//            return 0
//        }
//    }
        
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
//            
//        // Configure the cell with dummy data
//        switch indexPath.section {
//        case 0:
//            if indexPath.item == 0 {
//                cell.titleLabel.text = "Blood Pressure"
//                cell.valueLabel.text = "125/83"
//                cell.unitLabel.text = "mmHg"
//                cell.iconImageView.image = UIImage(named: "icon_blood_pressure")
//            } else if indexPath.item == 1 {
//                cell.titleLabel.text = "Blood Sugar"
//                cell.valueLabel.text = "69"
//                cell.unitLabel.text = "mg/dL"
//                cell.iconImageView.image = UIImage(named: "icon_blood_sugar")
//            } else {
//                cell.titleLabel.text = "Heart Rate"
//                cell.valueLabel.text = "105"
//                cell.unitLabel.text =  "bpm"
//                cell.iconImageView.image = UIImage(named: "icon_heart_rate")
//            }
//        case 1:
//            if indexPath.item == 0 {
//                cell.titleLabel.text = "eGFR"
//                cell.valueLabel.text = "77"
//                cell.unitLabel.text = "mL/min"
//                cell.iconImageView.image = UIImage(named: "icon_egfr")
//            } else {
//                cell.titleLabel.text = "Creatinine"
//                cell.valueLabel.text = "1.4"
//                cell.unitLabel.text = "mg/dL"
//                cell.iconImageView.image = UIImage(named: "icon_creatinine")
//            }
//        case 2:
//            cell.titleLabel.text = "Haemoglobin"
//            cell.valueLabel.text = "8.70"
//            cell.unitLabel.text = "g/dL"
//            cell.iconImageView.image = UIImage(named: "icon_haemoglobin")
//        default:
//            break
//        }
//            
//        return cell
//    }
////        
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
//            
//        // Configure the header with dummy data
//        switch indexPath.section {
//        case 0:
//            header.titleLabel.text = "Current Vitals"
//        case 1:
//                header.titleLabel.text = "Last Tests"
//        case 2:
//            header.titleLabel.text = "Recent Report"
//        default:
//            break
//        }
//            
//        return header
//    }
//        
//    func createLayout() -> UICollectionViewLayout {
//        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            // Define the item size
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            
//            // Define the group size and the number of items in the group
//            let groupSize: NSCollectionLayoutSize
//            let group: NSCollectionLayoutGroup
//            if sectionIndex == 0 {
//                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item])
//                            
//                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(300))
//                group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, nestedGroup])
//            } else if sectionIndex == 1 {
//                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                               heightDimension: .absolute(150))
//                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            } else {
//                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                               heightDimension: .absolute(150))
//                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            }
//                        
//            // Define the section and its content insets
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
//                        
//            // Add section header
//            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                                heightDimension: .estimated(44))
//            let header = NSCollectionLayoutBoundarySupplementaryItem(
//                            layoutSize: headerSize,
//                            elementKind: UICollectionView.elementKindSectionHeader,
//                            alignment: .top)
//                        section.boundarySupplementaryItems = [header]
//                        
//            return section
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the XIBs for the cell and header
        healthViewCollectionView.register(UINib(nibName: "CurrentVitalsCell", bundle: nil), forCellWithReuseIdentifier: "CurrentVitalsCell")
        healthViewCollectionView.register(UINib(nibName: "BloodPressureCell", bundle: nil), forCellWithReuseIdentifier: "BloodPressureCell")
        
        healthViewCollectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
               
        // Set up data source and delegate
        healthViewCollectionView.delegate = self
        healthViewCollectionView.dataSource = self
        healthViewCollectionView.collectionViewLayout = createLayout()
        // Register header view
        healthViewCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.currentVitalsSection()
            case 1:
                return self.lastTestSection()
            case 2:
                return self.recentReportSection()
            default:
                return nil
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1 // Recent Report
//        case 1:
//            return 2 // Last Tests
//        case 2:
//            return 3 // Current Vitals
//        default:
//             return 0
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView

        // Configure the header with dummy data
        switch indexPath.section {
        case 0:
            header.titleLabel.text = "Current Vitals"
        case 1:
                header.titleLabel.text = "Last Tests"
        case 2:
            header.titleLabel.text = "Recent Report"
        default:
            break
        }
            return header
    }

    func currentVitalsSection() -> NSCollectionLayoutSection {
        // Blood Pressure item
        let bloodPressureItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let bloodPressureItem = NSCollectionLayoutItem(layoutSize: bloodPressureItemSize)
        bloodPressureItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Blood Sugar and Heart Rate items
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Nested group for Blood Sugar and Heart Rate
        let smallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let smallGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallGroupSize, subitems: [smallItem, smallItem])
        
        // Combined group with Blood Pressure and the nested group
        let combinedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6))
        let combinedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: combinedGroupSize, subitems: [bloodPressureItem, smallGroup])
        
        // Section
        let section = NSCollectionLayoutSection(group: combinedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    func lastTestSection() -> NSCollectionLayoutSection {
        // Items
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    func recentReportSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3 // Number of items in the first section
        } else if section == 1 {
            return 2 // Number of items in the second section
        } else {
            return 1 // Number of items in the third section
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .systemBlue // Customize your cell
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        // Configure the cell with dummy data
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BloodPressureCell", for: indexPath) as! BloodPressureCell
                cell.titleLabel.text = "Blood Pressure"
                cell.value1Label.text = "125"
                cell.value2Label.text = "83"
                cell.unitLabel.text = "mmHg"
                cell.iconImageView.image = UIImage(named: "icon_blood_pressure")
                return cell
            } else if indexPath.item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                cell.titleLabel.text = "Blood Sugar"
                cell.valueLabel.text = "69"
                cell.unitLabel.text = "mg/dL"
                cell.iconImageView.image = UIImage(named: "icon_blood_sugar")
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                cell.titleLabel.text = "Heart Rate"
                cell.valueLabel.text = "105"
                cell.unitLabel.text =  "bpm"
                cell.iconImageView.image = UIImage(named: "icon_heart_rate")
                return cell
            }
        case 1:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                cell.titleLabel.text = "eGFR"
                cell.valueLabel.text = "77"
                cell.unitLabel.text = "mL/min"
                cell.iconImageView.image = UIImage(named: "icon_egfr")
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                cell.titleLabel.text = "Creatinine"
                cell.valueLabel.text = "1.4"
                cell.unitLabel.text = "mg/dL"
                cell.iconImageView.image = UIImage(named: "icon_creatinine")
                return cell
            }
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
            cell.titleLabel.text = "Haemoglobin"
            cell.valueLabel.text = "8.70"
            cell.unitLabel.text = "g/dL"
            cell.iconImageView.image = UIImage(named: "icon_haemoglobin")
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
            return cell
        }
    }
}

