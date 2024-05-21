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
        
        updateUI()
    }
    
    func updateUI() {
    
    //Current Vitals UI
        //Current Vitals Back View
        currentVitalsBackView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        currentVitalsBackView.layer.cornerRadius = 10
        
        //Sub Views
        bpView.layer.cornerRadius = 10
        egfrView.layer.cornerRadius = 10
        bloodSugarView.layer.cornerRadius = 10
        hrView.layer.cornerRadius = 10
        creatinineView.layer.cornerRadius = 10
        
    //
    }
}
