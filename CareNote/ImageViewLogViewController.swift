//
//  ImageViewLogViewController.swift
//  CareNote
//
//  Created by Sameer Verma on 11/06/24.
//

import UIKit


var imageDoc: UIImage = UIImage()
var documentName : String = ""

class ImageViewLogViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var documentImageScanned: UIImageView!
    
    @IBOutlet var documentSaveAs: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = dataController.getImages().first else { return }
        imageDoc = image.image!
        documentImageScanned.image = image.image!

        // Do any additional setup after loading the view.
        documentSaveAs.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Dismiss the keyboard
            textField.resignFirstResponder()
            return true
        }
    @IBAction func SaveButtonClicked(_ sender: UIButton) {
        documentName = documentSaveAs.text ?? "No Name"
        if documentTypeSelected == "Doctor Visit"{
            print("Doctor Name \(DoctorName) \nDate of Visit \(DateVisit) \(Diago) and \nMedicine Name \(MedicineName) \(Nextappoint)")
        }
        else if documentTypeSelected == "Lab Report"{
            print("Lab report")
        }
        else{
            print("None")
        }
//        DataController.addConsultation(title: title ?? <#default value#>, dateOfConsultation: DateVisit, user: user, doctor: DoctorName, consultationDocuments: consultationDocuments)
        
        dataController.addDoctorVisitDetailsDataStore(dateOfVisit: DateVisit, nameOfDoctor: DoctorName, reasonOfVisit: Diago, nextAppointmentDate: Nextappoint, adviceByDoctor: "")
//        TimelineCollectionViewCell().configureCell(date: DateVisit, month: DateVisit, title: DoctorName, description: Diago, notes: "nil ", nextAppointmentDate: Nextappoint)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
