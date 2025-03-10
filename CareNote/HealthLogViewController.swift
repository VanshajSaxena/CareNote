//
//  HealthLogViewController.swift
//  CareNote
//
//  Created by Batch-2 on 20/05/24.
//

import UIKit
import VisionKit

class HealthLogViewController: UIViewController, VNDocumentCameraViewControllerDelegate {
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthLog"
        super.tabBarItem.image = UIImage(systemName: "calendar.circle")
        super.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
    }

//    @IBOutlet var filter: UIDatePicker!
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
    }
    @IBOutlet var timelineSegmentView: UIView!
    
    @IBOutlet var documentGallerySegmentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(timelineSegmentView)
        print("Doctor Name \(DoctorName) \nDate of Visit \(DateVisit) \(Diago) and \nMedicine Name \(MedicineName) \(Nextappoint)")
        
//        if #available(iOS 17.4, *) {
//            filter.datePickerMode = .yearAndMonth
//        } else {
// Fallback on earlier versions
//        }
//        filter.addTarget(self, action: #selector(filter(_:)), for: .valueChanged)
//        filter.addTarget(self, action: #selector(filter(_:)), for: .valueChanged)
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
    }
    
    @objc func filter(_ sender: UIDatePicker) {


//        let selectedDate = sender.date
        
//        let calendar = Calendar.current
//        let selectedDate = sender.date
//        
//        let calendar = Calendar.current
//        let month = calendar.component(.month, from: selectedDate)
//        let year = calendar.component(.year, from: selectedDate)
        
        
//        let calendar = Calendar.current
//        let month = calendar.component(.month, from: selectedDate)
//        let year = calendar.component(.year, from: selectedDate)
//        filteredEntries = timelineEntries.filter { entry in
//            let entryMonth = calendar.component(.month, from: entry.date)
//            let yearMonth = calendar.component(.year, from: entry.date)
//            return entryMonth == month && entryYear == year
//        }
        
    }
    

//    func presentDocumentScanner() {
//        let scannerViewController = VNDocumentCameraViewController()
//        scannerViewController.delegate = self
//        present(scannerViewController, animated: true)
//    }
//    
//    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
//        // Handle the cancellation here
//        controller.dismiss(animated: true)
//    }

    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(timelineSegmentView)
        case 1:
            self.view.bringSubviewToFront(documentGallerySegmentView)
        default:
            break
        }
        
    }
    


//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
//        // Handle the failure here
//        print(error.localizedDescription)
//        controller.dismiss(animated: true)
//    }
//    
//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
//            // Handle the scanned documents here
//            copyCSVToDocuments(fileName: "ParametersCSV")
//            processCSVFile()
//            for pageIndex in 0..<scan.pageCount {
//                let scannedImage = scan.imageOfPage(at: pageIndex)
//                var images = dataController.getImages()
//                images.append(Images(id: UUID(), name: "newImage", image: scannedImage))
//                getText(from: scannedImage)
//                dataController.saveData()
//            }
//        controller.dismiss(animated: true)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewLogViewController") as! ImageViewLogViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

//    @IBAction func addButtonPressed(_ sender: Any) {
//        presentDocumentScanner()
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindSegueHealthLog(_ sender: UIStoryboardSegue){
        print("Your data is save")
        print(dataController.doctorVisitDetailsDataStore)
    }
    
    
   
}
