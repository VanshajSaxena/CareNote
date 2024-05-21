//
//  HealthViewViewController.swift
//  CareNote
//
//  Created by Batch-1 on 21/05/24.
//

import UIKit

class HealthViewViewController: UIViewController {

    @IBOutlet var currentVitalsBackView: UIView!
    @IBOutlet var currentVitalsLabel: UILabel!
    @IBOutlet var currentVitalsButton: UIButton!
    @IBOutlet var bpView: UIView!
    @IBOutlet var egfrView: UIView!
    @IBOutlet var bloodSugarView: UIView!
    @IBOutlet var hrView: UIView!
    @IBOutlet var creatinineView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentVitalsBackView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        currentVitalsBackView.layer.cornerRadius = 10
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
