//
//  AddVisitTableViewController.swift
//  CareNote
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit
import VisionKit
var documentTypeSelected : String = ""

class AddVisitTableViewController: UITableViewController,VNDocumentCameraViewControllerDelegate {
    
    
    @IBOutlet var documnetPopButton: UIButton!
    @IBOutlet var addVisitDateLabel: UILabel!
    @IBOutlet var addVisitDatePicker: UIDatePicker!
    
    
    //commented as it is not necessary in the file currently
//    @IBOutlet var documentNameLabel: UILabel!
//    @IBOutlet var documentDateLabel: UILabel!
    
    var addVisitDateLabelIndexPath = IndexPath(row: 0, section: 0)
    var addVisitDatePickerIndexPath = IndexPath(row: 1, section: 0)
    
    var isAddVisitDatePickerVisible:Bool = false {
        didSet {
            addVisitDatePicker.isHidden = !isAddVisitDatePickerVisible
        }
    }
    
    struct addVisit: Codable {
        var date : Date
        var document : String
        var note : String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDocumentPopButton()
        updateDateView()
//        documentNameLabel.text = "\(documentName).pdf"
//        loadSavedVisit()
    }
    
    func updateDateView() {
//        documentDateLabel.text=addVisitDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        addVisitDateLabel.text = addVisitDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func setDocumentPopButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)
            documentTypeSelected = "\(action.title)"
            print("Sameer Verma created \(documentTypeSelected)")
        }
        documnetPopButton.menu = UIMenu (children : [
        UIAction(title : "Document Type", state :.on, handler: optionClosure),
        UIAction(title : "Doctor Visit", handler: optionClosure),
        UIAction(title : "Lab Report", handler: optionClosure)
        ])
        documnetPopButton.showsMenuAsPrimaryAction = true
        documnetPopButton.changesSelectionAsPrimaryAction = true
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case addVisitDatePickerIndexPath:
            return isAddVisitDatePickerVisible ? 217 : 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == addVisitDateLabelIndexPath {
            isAddVisitDatePickerVisible.toggle()
        } else {
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func addVisitDateSelected(_ sender: UIDatePicker) {
        updateDateView()
    }
    
//MARK: - Scanning and Camera open and closing Coding From below
    
    
    @IBAction func openCameraButton(_ sender: UIBarButtonItem) {
        
        presentDocumentScanner()
    }
    func presentDocumentScanner() {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = self
        present(scannerViewController, animated: true)
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewLogViewController") as! ImageViewLogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
