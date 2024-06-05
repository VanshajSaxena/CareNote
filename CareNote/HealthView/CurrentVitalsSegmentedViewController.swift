//
//  CurrentVitalsSegmentedViewController.swift
//  CareNote
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit
import Charts

class CurrentVitalsSegmentedViewController: UIViewController {

    //segmented outlet
    @IBOutlet var vitalsSegmentedControl: UISegmentedControl!
    @IBOutlet var timeSegmentedControl: UISegmentedControl!
    
    //labels outlet
    @IBOutlet var parameterNameLabel: UILabel!
    @IBOutlet var subParaName1: UILabel!
    @IBOutlet var subParaName2: UILabel!
    @IBOutlet var subParaValue1: UILabel!
    @IBOutlet var subParaValue2: UILabel!
    
    //Comparision View Outlets
    //2 sub para
    @IBOutlet var subParameter1Label: UILabel!
    @IBOutlet var subParameter2Label: UILabel!
    @IBOutlet var timeLabel1: UILabel!
    @IBOutlet var timeLabel2: UILabel!
    
    //solo sub para
    @IBOutlet var subParameterLabel: UILabel!
    @IBOutlet var soloTimeLabel1: UILabel!
    @IBOutlet var soloTimeLabel2: UILabel!
    
    //UI view outlet
    @IBOutlet var bpComparisionView: UIView!
    @IBOutlet var comparisionView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()
        
        bpComparisionView.layer.cornerRadius = 8
        comparisionView.layer.cornerRadius = 8
        
        // Set BP as default view
        vitalsSegmentedControl.selectedSegmentIndex = 0
        vitalsSegmentedControl(self.vitalsSegmentedControl)
        
        //comparision view's default view
        timeSegmentedControl.selectedSegmentIndex = 0
        timeSegmentedControl(self.timeSegmentedControl)
    }
    
    //GradientBackground
    public func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let colour1 = UIColor(red: 0x66 / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        let colour2 = UIColor(red: 0x66 / 255.0, green: 0xCC / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        
        gradientLayer.colors = [colour1.cgColor, colour2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func vitalsSegmentedControl(_ sender: UISegmentedControl) {
        switch vitalsSegmentedControl.selectedSegmentIndex {
        case 0:
            parameterNameLabel.text = "Blood Pressure"
            subParaName1.text = "Systolic"
            subParaValue1.text = "127-152"
            subParaName2.text = "Diastolic"
            subParaValue2.text = "84-89"
            subParameter1Label.text = "Systolic"
            subParameter2Label.text = "Diastolic"
            subParaName2.isHidden = false
            subParaValue2.isHidden = false
            bpComparisionView.isHidden = false
            comparisionView.isHidden = true
        case 1:
            parameterNameLabel.text = "Heart Rate"
            subParaName1.text = "Heart Rate"
            subParaValue1.text = "79-98"
            subParameterLabel.text = "Heart Rate"
            subParaName2.isHidden = true
            subParaValue2.isHidden = true
            bpComparisionView.isHidden = true
            comparisionView.isHidden = false
        case 2:
            parameterNameLabel.text = "eGFR"
            subParaName1.text = "eGFR"
            subParaValue1.text = "45-83"
            subParameterLabel.text = "eGFR"
            subParaName2.isHidden = true
            subParaValue2.isHidden = true
            bpComparisionView.isHidden = true
            comparisionView.isHidden = false
        case 3:
            parameterNameLabel.text = "Creatinine"
            subParaName1.text = "Creatinine"
            subParaValue1.text = "1.1-2.8"
            subParameterLabel.text = "Creatinine"
            subParaName2.isHidden = true
            subParaValue2.isHidden = true
            bpComparisionView.isHidden = true
            comparisionView.isHidden = false
        case 4:
            parameterNameLabel.text = "Sugar"
            subParaName1.text = "Blood Sugar"
            subParaValue1.text = "65-98"
            subParameterLabel.text = "Sugar"
            subParaName2.isHidden = true
            subParaValue2.isHidden = true
            bpComparisionView.isHidden = true
            comparisionView.isHidden = false
        default:
            print("Fatal Error")
        }
        setTimeSegmentControl()
    }
    @IBAction func timeSegmentedControl(_ sender: UISegmentedControl) {
        setTimeSegmentControl()
    }
    
    func setTimeSegmentControl() {
        if vitalsSegmentedControl.selectedSegmentIndex == 0 {
            switch timeSegmentedControl.selectedSegmentIndex {
            case 0:
                timeLabel1.text = "Today"
                timeLabel2.text = "Yesterday"
            case 1:
                timeLabel1.text = "Current Week"
                timeLabel2.text = "Previous Week"
            case 2:
                timeLabel1.text = "Current Month"
                timeLabel2.text = "Previous Month"
            case 3:
                timeLabel1.text = "Current Year"
                timeLabel2.text = "Previous Year"
            default:
                print("Fatal Error")
            }
        } else {
            switch timeSegmentedControl.selectedSegmentIndex {
            case 0:
                soloTimeLabel1.text = "Today"
                soloTimeLabel2.text = "Yesterday"
            case 1:
                soloTimeLabel1.text = "Current Week"
                soloTimeLabel2.text = "Previous Week"
            case 2:
                soloTimeLabel1.text = "Current Month"
                soloTimeLabel2.text = "Previous Month"
            case 3:
                soloTimeLabel1.text = "Current Year"
                soloTimeLabel2.text = "Previous Year"
            default:
                print("Fatal Error")
            }
        }
    }
}
