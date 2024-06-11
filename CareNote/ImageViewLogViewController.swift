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
        guard let image = UIImage(named: "image4") else { return }
        imageDoc = image
        documentImageScanned.image = image

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
