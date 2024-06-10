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
    
    var dayData: [Graph] = (1...24).map { Graph(time: $0, value: Double.random(in: 60...100)) }
    var weekData: [Graph] = (1...7).map { Graph(time: $0, value: Double.random(in: 60...100)) }
    var monthData: [Graph] = (1...31).map { Graph(time: $0, value: Double.random(in: 60...100)) }
    var yearData: [Graph] = (1...12).map { Graph(time: $0, value: Double.random(in: 60...100)) }

    var currentGraphData: [Graph] = []
    var xAxisRange: ClosedRange<Int> = 1...31
    var xAxisStride: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()

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
        
        let graphView = GraphContainerView(graphData: currentGraphData, xAxisRange: xAxisRange, xAxisStride: xAxisStride)
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
          switch vitalsSegmentedControl.selectedSegmentIndex {
          case 0:
              
              graphTimeChange()
          case 1:
              
              graphTimeChange()
          case 2:
              
              graphTimeChange()
          case 3:
              
              graphTimeChange()
          case 4:
              
              graphTimeChange()
          default:
              graphTimeChange()
          }
        
                  currentVitalsGraph()
              }
        
    func graphTimeChange() {
        switch timeSegmentedControl.selectedSegmentIndex {
        case 0:
            timeLabel1.text = "Today"
            timeLabel2.text = "Yesterday"
            currentGraphData = dayData
            xAxisRange = 1...24
            xAxisStride = 3
        case 1:
            timeLabel1.text = "Current Week"
            timeLabel2.text = "Previous Week"
            currentGraphData = weekData
            xAxisRange = 1...7
            xAxisStride = 1
        case 2:
            timeLabel1.text = "Current Month"
            timeLabel2.text = "Previous Month"
            currentGraphData = monthData
            xAxisRange = 1...31
            xAxisStride = 3
        case 3:
            timeLabel1.text = "Current Year"
            timeLabel2.text = "Previous Year"
            currentGraphData = yearData
            xAxisRange = 1...12
            xAxisStride = 1
        default:
            print("Fatal Error")
        }
    }
}
