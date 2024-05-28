//
//  HealthViewViewController.swift
//  CareNote
//
//  Created by Batch-1 on 21/05/24.
//

import UIKit

class HealthViewViewController: UIViewController,UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {

    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "doc.text.image")
        super.tabBarItem.selectedImage = UIImage(systemName: "doc.text.image.fill")
    }

    @IBOutlet var currentVitalsBackView: UIView!
    @IBOutlet var recentReportBackView: UIView!
    @IBOutlet var currentVitalsLabel: UILabel!
    @IBOutlet var currentVitalsButton: UIButton!
    @IBOutlet var bpView: UIView!
    @IBOutlet var egfrView: UIView!
    @IBOutlet var bloodSugarView: UIView!
    @IBOutlet var hrView: UIView!
    @IBOutlet var creatinineView: UIView!
    @IBOutlet var recentReportTableView: UITableView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var verticalStackView: UIStackView!
    var tableViewHeightConstraint: NSLayoutConstraint?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dummy table
        recentReportTableView.dataSource = self
        recentReportTableView.delegate = self
        
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
        
    //Recent Report UI
        //Recent Report Back View
        recentReportBackView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        recentReportBackView.layer.cornerRadius = 10
        
        //Table View
        recentReportTableView.layer.cornerRadius = 10
        
        recentReportTableView.isScrollEnabled = false
        recentReportTableView.reloadData()
        NSLayoutConstraint.activate([
            recentReportTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        recentReportTableView.estimatedRowHeight = 100
        recentReportTableView.rowHeight = UITableView.automaticDimension
        setupTableViewHeightConstraint()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        updateTableViewHeight()
//    }
    
    
//    private func updateTableViewHeight() {
//        recentReportTableView.layoutIfNeeded()
//        var frame = recentReportTableView.frame
//        frame.size.height = recentReportTableView.contentSize.height
//        recentReportTableView.frame = frame
//        
//        updateScrollViewContentSize()
//    }
//    
//    private func updateScrollViewContentSize() {
//        recentReportBackView.layoutIfNeeded()
//        scrollView.contentSize = recentReportBackView.frame.size
//    }
    func setupTableViewHeightConstraint() {
            tableViewHeightConstraint = recentReportTableView.heightAnchor.constraint(equalToConstant: 0)
            tableViewHeightConstraint?.isActive = true
            recentReportTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }

        // Observe content size changes and update the height constraint
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "contentSize" {
                if let newSize = change?[.newKey] as? CGSize {
                    tableViewHeightConstraint?.constant = newSize.height
                }
            }
        }
    //Dummy Data
    struct BloodTest {
        let parameter: String
        let value: String
        let unit: String
        let isAbnormal: Bool
    }
    
    var bloodTests: [BloodTest] = [
        BloodTest(parameter: "Haemoglobin", value: "8.70", unit: "g/dL", isAbnormal: true),
        BloodTest(parameter: "Packed Cell Volume (HCT)", value: "27.6", unit: "%", isAbnormal: true),
        BloodTest(parameter: "R.B.C. Count", value: "4.34", unit: "mill/μL", isAbnormal: false),
        BloodTest(parameter: "W.B.C. Count", value: "4600", unit: "cell/μL", isAbnormal: false),
        BloodTest(parameter: "Packed Cell Volume (HCT)", value: "27.6", unit: "%", isAbnormal: true),
        BloodTest(parameter: "R.B.C. Count", value: "4.34", unit: "mill/μL", isAbnormal: false),
        BloodTest(parameter: "W.B.C. Count", value: "4600", unit: "cell/μL", isAbnormal: false),
        BloodTest(parameter: "Packed Cell Volume (HCT)", value: "27.6", unit: "%", isAbnormal: true),
        BloodTest(parameter: "R.B.C. Count", value: "4.34", unit: "mill/μL", isAbnormal: false),
        BloodTest(parameter: "W.B.C. Count", value: "4600", unit: "cell/μL", isAbnormal: false),
        BloodTest(parameter: "Packed Cell Volume (HCT)", value: "27.6", unit: "%", isAbnormal: true),
        BloodTest(parameter: "R.B.C. Count", value: "4.34", unit: "mill/μL", isAbnormal: false),
        BloodTest(parameter: "W.B.C. Count", value: "4600", unit: "cell/μL", isAbnormal: false),
        BloodTest(parameter: "Packed Cell Volume (HCT)", value: "27.6", unit: "%", isAbnormal: true),
        BloodTest(parameter: "R.B.C. Count", value: "4.34", unit: "mill/μL", isAbnormal: false),
        BloodTest(parameter: "W.B.C. Count", value: "4600", unit: "cell/μL", isAbnormal: false)
    ]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return bloodTests.count
        }

    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodTestCell", for: indexPath)

            let parameterLabel = cell.viewWithTag(1) as! UILabel
            let valueLabel = cell.viewWithTag(2) as! UILabel
            let unitLabel = cell.viewWithTag(3) as! UILabel

            let bloodTest = bloodTests[indexPath.row]

            parameterLabel.text = bloodTest.parameter
            valueLabel.text = bloodTest.value
            unitLabel.text = bloodTest.unit

            // Highlight abnormal values
            if bloodTest.isAbnormal {
                valueLabel.textColor = .red
            } else {
                valueLabel.textColor = .green
            }

        return cell
    }
}
