//
//  CurrentVitalsSegmentedViewController.swift
//  CareNote
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit
import Charts
import SwiftUI

class CurrentVitalsSegmentedViewController: UIViewController {
    
    var bloodPressure: MedicalParameter!
    var heartRate: MedicalParameter!
    var eGFR: MedicalParameter!
    var creatinine: MedicalParameter!
    var bloodSugar: MedicalParameter!

    var currentParameter: MedicalParameter?
    
    // The currently selected time segment
    var selectedTimeSegment: TimeSegment = .day
    
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
    
    @IBOutlet var graphContainer: UIView!
    
    var dayData: [Graph] = []
    var weekData: [Graph] = []
    var monthData: [Graph] = []
    var yearData: [Graph] = []

    var currentGraphData: [Graph] = []
    var xAxisRange: ClosedRange<Int> = 1...31
    var xAxisStride: Int = 3
    var yAxisRange: ClosedRange<Int> = 0...200
    var yAxisStride: Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()
        
        initializeMedicalParameter()
        // Set BP as default parameter
        currentParameter = bloodPressure
        updateGraphData(for: bloodPressure, timeSegment: selectedTimeSegment)

        bpComparisionView.layer.cornerRadius = 8
        comparisionView.layer.cornerRadius = 8

        // Set BP as default view
        vitalsSegmentedControl.selectedSegmentIndex = 0
        vitalsSegmentedControl(self.vitalsSegmentedControl)

        // Comparision view's default view
        timeSegmentedControl.selectedSegmentIndex = 0
        timeSegmentedControl(self.timeSegmentedControl)

        setTimeSegmentControl()
    }
    
    func initializeMedicalParameter() {
        bloodPressure = dataController.getMedicalParameter(name: "Blood Pressure")
        heartRate = dataController.getMedicalParameter(name: "Heart Rate")
        eGFR = dataController.getMedicalParameter(name: "eGFR")
        creatinine = dataController.getMedicalParameter(name: "Creatinine")
        bloodSugar = dataController.getMedicalParameter(name: "Blood Sugar")
        
        // Check for nil parameters and handle accordingly
        if bloodPressure == nil {
            print("Blood Pressure parameter not found!")
        }
        if heartRate == nil {
            print("Heart Rate parameter not found!")
        }
        if eGFR == nil {
            print("eGFR parameter not found!")
        }
        if creatinine == nil {
            print("Creatinine parameter not found!")
        }
        if bloodSugar == nil {
            print("Blood Sugar parameter not found!")
        }
    }
    
    func updateGraphData(for parameter: MedicalParameter, timeSegment: TimeSegment) {
        currentGraphData = parameter.getGraphData(for: timeSegment)
        // Now use `currentGraphData` to update your graph view
        // For example:
        updateGraphView(with: currentGraphData)
    }
    
    func updateGraphView(with data: [Graph]) {
        // This is where you would update your graph view with the new data
        // For example, you might have a line chart or bar chart that you update here
        // This is a placeholder implementation
        for graphPoint in data {
            print("Time: \(graphPoint.time), Value: \(graphPoint.value)")
        }
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
    
    func currentVitalsGraph() {
        // Remove all subviews from graphContainer to avoid overlapping
        for subview in graphContainer.subviews {
            subview.removeFromSuperview()
        }
        
        let graphView = GraphContainerView(graphData: currentGraphData, xAxisRange: xAxisRange,yAxisRange: yAxisRange, xAxisStride: xAxisStride, yAxisStride: yAxisStride)
        let hostingController = UIHostingController(rootView: graphView)

        addChild(hostingController)
        graphContainer.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        hostingController.view.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: graphContainer.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: graphContainer.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: graphContainer.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: graphContainer.trailingAnchor)
        ])

        hostingController.didMove(toParent: self)
    }


      @IBAction func vitalsSegmentedControl(_ sender: UISegmentedControl) {
          switch sender.selectedSegmentIndex {
          case 0:
                currentParameter = bloodPressure
              parameterNameLabel.text = "Blood Pressure"
              subParaName1.text = "Systolic"
              subParaValue1.text = "127-152"
              subParaName2.text = "Diastolic"
              subParaValue2.text = "84-89"
              subParameter1Label.text = "Systolic"
              subParameter2Label.text = "Diastolic"
              yAxisRange = 60...160
              yAxisStride = 10
              subParaName2.isHidden = false
              subParaValue2.isHidden = false
              bpComparisionView.isHidden = false
              comparisionView.isHidden = true
          case 1:
                  currentParameter = heartRate
              parameterNameLabel.text = "Heart Rate"
              subParaName1.text = "Heart Rate"
              subParaValue1.text = "79-98"
              subParameterLabel.text = "Heart Rate"
              yAxisRange = 10...120
              yAxisStride = 10
              subParaName2.isHidden = true
              subParaValue2.isHidden = true
              bpComparisionView.isHidden = true
              comparisionView.isHidden = false
          case 2:
                  currentParameter = eGFR
              parameterNameLabel.text = "eGFR"
              subParaName1.text = "eGFR"
              subParaValue1.text = "45-83"
              subParameterLabel.text = "eGFR"
                  yAxisRange = 40...120
              yAxisStride = 10
              subParaName2.isHidden = true
              subParaValue2.isHidden = true
              bpComparisionView.isHidden = true
              comparisionView.isHidden = false
          case 3:
                  currentParameter = creatinine
              parameterNameLabel.text = "Creatinine"
              subParaName1.text = "Creatinine"
              subParaValue1.text = "1.1-2.8"
              subParameterLabel.text = "Creatinine"
              yAxisRange = 0...5
              yAxisStride = 1
              subParaName2.isHidden = true
              subParaValue2.isHidden = true
              bpComparisionView.isHidden = true
              comparisionView.isHidden = false
          case 4:
                  currentParameter = bloodSugar
              parameterNameLabel.text = "Sugar"
              subParaName1.text = "Blood Sugar"
              subParaValue1.text = "65-98"
              subParameterLabel.text = "Sugar"
              yAxisRange = 40...140
              yAxisStride = 10
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
          switch vitalsSegmentedControl.selectedSegmentIndex {
          case 0, 1, 2, 3, 4:
              graphTimeChange()
          default:
              graphTimeChange()
          }
          currentVitalsGraph()
      }
        
    func graphTimeChange() {
        guard let parameter = currentParameter else { return }
        
        switch timeSegmentedControl.selectedSegmentIndex {
        case 0:
            timeLabel1.text = "Today"
            soloTimeLabel1.text = "Today"
            timeLabel2.text = "Yesterday"
            soloTimeLabel2.text = "Yesterday"
                currentGraphData = parameter.getGraphData(for: .day)
            xAxisRange = 0...24
            xAxisStride = 3
        case 1:
            timeLabel1.text = "Current Week"
            soloTimeLabel1.text = "Current Week"
            timeLabel2.text = "Previous Week"
            soloTimeLabel2.text = "Previous Week"
                currentGraphData = parameter.getGraphData(for: .week)
            currentGraphData = weekData
            xAxisRange = 0...7
            xAxisStride = 1
        case 2:
            timeLabel1.text = "Current Month"
            soloTimeLabel1.text = "Current Month"
            timeLabel2.text = "Previous Month"
            soloTimeLabel2.text = "Previous Month"
                currentGraphData = parameter.getGraphData(for: .month)
            currentGraphData = monthData
            xAxisRange = 0...31
            xAxisStride = 3
        case 3:
            timeLabel1.text = "Current Year"
            soloTimeLabel1.text = "Current Year"
            timeLabel2.text = "Previous Year"
            soloTimeLabel2.text = "Previous Year"
                currentGraphData = parameter.getGraphData(for: .year)
            currentGraphData = yearData
            xAxisRange = 0...12
            xAxisStride = 1
        default:
            print("Fatal Error")
        }
    }
}
