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
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Register the XIBs for the cell and header
            healthViewCollectionView.register(UINib(nibName: "CurrentVitalsCell", bundle: nil), forCellWithReuseIdentifier: "CurrentVitalsCell")
            healthViewCollectionView.register(UINib(nibName: "BloodPressureCell", bundle: nil), forCellWithReuseIdentifier: "BloodPressureCell")
            healthViewCollectionView.register(UINib(nibName: "recentReportCell", bundle: nil), forCellWithReuseIdentifier: "recentReportCell")

            
            
            // Set up data source and delegate
            healthViewCollectionView.delegate = self
            healthViewCollectionView.dataSource = self
            
            // Register header view
//            healthViewCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
            
            // Set up collection view compositional layout
            healthViewCollectionView.setCollectionViewLayout(generateLayout(), animated: true)

            //Set up headers
            healthViewCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            
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
            section.boundarySupplementaryItems = [header]
            return section
        }
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
        
        // Create the section
        let currentVitalsSection = NSCollectionLayoutSection(group: mainGroup)
        
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
        //last test section
        let lastTestSection = NSCollectionLayoutSection(group: lastTestGroup)
        
        return lastTestSection
    }
    
    // layout for recent report
    func recentReportLayout() -> NSCollectionLayoutSection {
        let recentReportItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let recentReportItem = NSCollectionLayoutItem(layoutSize: recentReportItemSize)
        recentReportItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let recentReportGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(450)) // need change
        let recentReportGroup = NSCollectionLayoutGroup.vertical(layoutSize: recentReportGroupSize, subitems: [recentReportItem])
        
        let recentReportSection = NSCollectionLayoutSection(group: recentReportGroup)
        
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
                    case 1:
                        header.headerLabel.text = "Last Tests"
                    case 2:
                        header.headerLabel.text = "Recent Report"
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
                    cell.titleLabel.text = "Blood Pressure"
                    cell.value1Label.text = "125"
                    cell.value2Label.text = "83"
                    cell.unitLabel.text = "mmHg"
                    cell.iconImageView.image = UIImage(named: "icon_blood_pressure")
                    cell.layer.cornerRadius = 8
                    return cell
                } else if indexPath.item == 1 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                    cell.titleLabel.text = "Blood Sugar"
                    cell.valueLabel.text = "69"
                    cell.unitLabel.text = "mg/dL"
                    cell.iconImageView.image = UIImage(named: "icon_blood_sugar")
                    cell.layer.cornerRadius = 8
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                    cell.titleLabel.text = "Heart Rate"
                    cell.valueLabel.text = "105"
                    cell.unitLabel.text = "bpm"
                    cell.iconImageView.image = UIImage(named: "icon_heart_rate")
                    cell.layer.cornerRadius = 8
                    return cell
                }
            case 1:
                if indexPath.item == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                    cell.titleLabel.text = "eGFR"
                    cell.valueLabel.text = "77"
                    cell.unitLabel.text = "mL/min"
                    cell.iconImageView.image = UIImage(named: "icon_egfr")
                    cell.layer.cornerRadius = 8
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                    cell.titleLabel.text = "Creatinine"
                    cell.valueLabel.text = "1.4"
                    cell.unitLabel.text = "mg/dL"
                    cell.iconImageView.image = UIImage(named: "icon_creatinine")
                    cell.layer.cornerRadius = 8
                    return cell
                }
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentReportCell", for: indexPath) as! recentReportCell
                cell.titleLabel.text = "Haemoglobin"
                cell.valueLabel.text = "8.70"
                cell.unitLabel.text = "g/dL"
                cell.layer.cornerRadius = 8
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                return cell
            }
        }
        
//        // UICollectionViewDelegateFlowLayout methods
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            // Return automatic size
//            return UICollectionViewFlowLayout.automaticSize
//        }
    }

