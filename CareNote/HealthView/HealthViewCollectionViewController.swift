//
//  HealthViewCollectionViewController.swift
//  CareNote
//
//  Created by Batch-1 on 29/05/24.
//

import UIKit
import VisionKit

class HealthViewCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, VNDocumentCameraViewControllerDelegate {
    
    //Code to make tab bar icon visible
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "doc.text.image")
        super.tabBarItem.selectedImage = UIImage(systemName: "doc.text.image.fill")
    }
    
    @IBOutlet var healthViewCollectionView: UICollectionView!
    @IBOutlet var addButton: UIBarButtonItem!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            dataController.loadData()

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Call your data reloading method here
        dataController.loadData()
        healthViewCollectionView.reloadData()
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
        lastTestSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        lastTestSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return lastTestSection
    }
    
    // layout for recent report
    func recentReportLayout() -> NSCollectionLayoutSection {
        let recentReportItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let recentReportItem = NSCollectionLayoutItem(layoutSize: recentReportItemSize)
        recentReportItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let recentReportGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(recentReportItem.layoutSize.heightDimension.dimension * CGFloat(dataController.returnRecentReportGroupSize())))
        let recentReportGroup = NSCollectionLayoutGroup.vertical(layoutSize: recentReportGroupSize, subitem: recentReportItem, count: dataController.returnRecentReportGroupSize())
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
            return dataController.getFilteredMedicalParameters().count
        default:
            return 0
        }
}
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
    
            // Configure the header
                switch indexPath.section {
                case 0:
                    header.headerLabel.text = "Current Vitals"
                    header.iconButton.isHidden = false
                case 1:
                    header.headerLabel.text = "Last Tests"
                    header.iconButton.isHidden = false
                case 2:
                    header.headerLabel.text = "Recent Report"
                    
                    // Create a DateFormatter
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    
                    // Get the current date and format it
                    let currentDate = Date()
                    let formattedDate = dateFormatter.string(from: currentDate)
                    header.subtitleLabel.text = formattedDate
                    header.subtitleLabel.isHidden = false
                    header.iconButton.isHidden = true
                default:
                    break
                }
                    return header
        }
        fatalError("Unexpected element kind")
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BloodPressureCell", for: indexPath) as! BloodPressureCell
                let bloodPressureParameter = dataController.getMedicalParameter(name: "Blood Pressure")
                cell.titleLabel.text = bloodPressureParameter?.getName()
                cell.value1Label.text = "-"
                cell.value1Label.textColor = UIColor.gray
                cell.value2Label.text = "-"
                cell.value1Label.textColor = UIColor.gray
                cell.unitLabel.text = bloodPressureParameter?.getUnitOfMeasure()
                cell.iconImageView.image = UIImage(systemName: "waveform.path.ecg")
                cell.iconImageView.tintColor = UIColor.systemBlue
                cell.layer.cornerRadius = 8
                return cell
            } else if indexPath.item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let bloodSugarParameter = dataController.getMedicalParameter(name: "Blood Sugar")
                bloodSugarParameter?.setMaxValue(maxValue: 100)
                bloodSugarParameter?.setMinValue(minValue: 70)
                cell.titleLabel.text = bloodSugarParameter?.getName()
                
                //Colour
                if let recentValue = bloodSugarParameter?.getRecentValue(),
                   let maxValue = bloodSugarParameter?.getMaxValue(),
                   let minValue = bloodSugarParameter?.getMinValue() {
                    
                    // Use recentValue, maxValue, and minValue safely
                    if Double(recentValue)! < maxValue && Double(recentValue)! > minValue {
                        cell.valueLabel.textColor = UIColor.green
                        cell.valueLabel.text = String(recentValue)
                    } else {
                        cell.valueLabel.textColor = UIColor.red
                        cell.valueLabel.text = String(recentValue)
                    }
                } else {
                    cell.valueLabel.textColor = UIColor.gray
                    cell.valueLabel.text = "-"
                }
                
                cell.unitLabel.text = bloodSugarParameter?.getUnitOfMeasure()
                cell.iconImageView.image = UIImage(systemName: "drop")
                cell.iconImageView.tintColor = UIColor.orange
                cell.layer.cornerRadius = 8
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let heartRateParameter = dataController.getMedicalParameter(name: "Heart Rate")
                heartRateParameter?.setMaxValue(maxValue: 100)
                heartRateParameter?.setMinValue(minValue: 60)
                cell.titleLabel.text = heartRateParameter?.getName()
                
                //Colour
                if let recentValue = heartRateParameter?.getRecentValue(),
                   let maxValue = heartRateParameter?.getMaxValue(),
                   let minValue = heartRateParameter?.getMinValue() {
                    
                    // Use recentValue, maxValue, and minValue safely
                    if Double(recentValue)! < maxValue && Double(recentValue)! > minValue {
                        cell.valueLabel.textColor = UIColor.green
                        cell.valueLabel.text = String(recentValue) // Convert Double to String
                    } else {
                        cell.valueLabel.textColor = UIColor.red
                        cell.valueLabel.text = String(recentValue) // Convert Double to String
                    }
                } else {
                    cell.valueLabel.textColor = UIColor.gray
                    cell.valueLabel.text = "-"
                }
                
                cell.unitLabel.text = heartRateParameter?.getUnitOfMeasure()
                cell.iconImageView.image = UIImage(systemName: "heart")
                cell.iconImageView.tintColor = UIColor.red
                cell.layer.cornerRadius = 8
                return cell
            }
        case 1:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let egfrParameter = dataController.getMedicalParameter(name: "eGFR")
                egfrParameter?.setMinValue(minValue: 60)
                cell.titleLabel.text = egfrParameter?.getName()
                
                //colour
                if let recentValue = egfrParameter?.getRecentValue(),
                   let minValue = egfrParameter?.getMinValue() {
                    
                    // Use recentValue, maxValue, and minValue safely
                    if Double(recentValue)! > minValue {
                        cell.valueLabel.textColor = UIColor.green
                        cell.valueLabel.text = String(recentValue)
                    } else {
                        cell.valueLabel.textColor = UIColor.red
                        cell.valueLabel.text = String(recentValue)
                    }
                } else {
                    cell.valueLabel.textColor = UIColor.gray
                    cell.valueLabel.text = "-"
                }
                
                cell.unitLabel.text = egfrParameter?.getUnitOfMeasure()
                cell.iconImageView.image = UIImage(systemName: "chart.bar.doc.horizontal")
                cell.iconImageView.tintColor = UIColor.systemGreen
                cell.layer.cornerRadius = 8
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
                let creatinine = dataController.getMedicalParameter(name: "Creatinine")
                creatinine?.setMaxValue(maxValue: 0.6)
                creatinine?.setMinValue(minValue: 1.3)
                cell.titleLabel.text = creatinine?.getName()
                
                //colour
                if let recentValue = creatinine?.getRecentValue(),
                   let maxValue = creatinine?.getMaxValue(),
                   let minValue = creatinine?.getMinValue() {
                    
                    // Use recentValue, maxValue, and minValue safely
                    if Double(recentValue)! < maxValue && Double(recentValue)! > minValue {
                        cell.valueLabel.textColor = UIColor.green
                        cell.valueLabel.text = String(recentValue)
                    } else {
                        cell.valueLabel.textColor = UIColor.red
                        cell.valueLabel.text = String(recentValue)
                    }
                } else {
                    // Handle the case where any of the values are nil
                    cell.valueLabel.textColor = UIColor.gray
                    cell.valueLabel.text = "-"
                }
                
                cell.unitLabel.text = creatinine?.getUnitOfMeasure()
                cell.iconImageView.image = UIImage(systemName: "cross.vial")
                cell.iconImageView.tintColor = UIColor.purple
                cell.layer.cornerRadius = 8
                return cell
            }
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentReportCell", for: indexPath) as! recentReportCell
                // Check if the index is valid in the array of medical parameters
                guard indexPath.item < dataController.getFilteredMedicalParameters().count else {
                    return cell
                }
                
                // Access the parameter at the specific index
                let parameter = dataController.getFilteredMedicalParameters()[indexPath.item]
                
                // Configure the cell with the parameter details
                cell.titleLabel.text = parameter.getName()
                cell.valueLabel.text = parameter.getRecentValue()
                cell.unitLabel.text = parameter.getUnitOfMeasure()
                cell.layer.cornerRadius = 8
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVitalsCell", for: indexPath) as! CurrentVitalsCell
            return cell
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        // Handle the cancellation here
        controller.dismiss(animated: true)
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        // Handle the failure here
        print(error.localizedDescription)
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // Handle the scanned documents here
            copyCSVToDocuments(fileName: "ParametersCSV")
            processCSVFile()
            for pageIndex in 0..<scan.pageCount {
                let scannedImage = scan.imageOfPage(at: pageIndex)
                var images = dataController.getImages()
                images.append(Images(id: UUID(), name: "newImage", image: scannedImage))
                getText(from: scannedImage)
                dataController.saveData()
            }
        controller.dismiss(animated: true)
    }
    
    func presentDocumentScanner() {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = self
        present(scannerViewController, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        presentDocumentScanner()
    }
}

