//
//  HealthLogViewController.swift
//  CareNote
//
//  Created by Batch-2 on 20/05/24.
//

import UIKit

class HealthLogViewController: UIViewController {
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthLog"
        super.tabBarItem.image = UIImage(systemName: "calendar.circle")
        super.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
    }

    @IBOutlet var filter: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filter.datePickerMode = .
        filter.addTarget(self, action: #selector(filter(_:)), for: .valueChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func filter(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: selectedDate)
        let year = calendar.component(.year, from: selectedDate)
        
        
//        filteredEntries = timelineEntries.filter { entry in
//            let entryMonth = calendar.component(.month, from: entry.date)
//            let yearMonth = calendar.component(.year, from: entry.date)
//            return entryMonth == month && entryYear == year
//        }
        
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
