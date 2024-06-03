//
//  HealthLogTableViewController.swift
//  CareNote
//
//  Created by Batch-2 on 30/05/24.
//

import UIKit

class HealthLogTableViewController: UITableViewController {
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthLog"
        super.tabBarItem.image = UIImage(systemName: "calendar.circle")
        super.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
    }
    
    @IBOutlet weak var filterDatePicker: UIDatePicker!
    
    @IBOutlet var monthYearLabel: UILabel!
    
    
    override func viewDidLoad() {
        
//        if #available(iOS 17.4, *) {
//            filterDatePicker.datePickerMode = .yearAndMonth
//        } else {
//            // Fallback on earlier versions
//        }
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
// SECTION 1 WOrk _----------------------------
    var segmentationControlIndexPath = IndexPath(row: 0, section: 0)
    var filterLabelHealthLogIndexPath = IndexPath(row: 1, section: 0)
    var datePickerHealthLogIndexPath = IndexPath(row: 2, section: 0)
    
    
    var isdatePickerHealthLogVisible : Bool = false {
        didSet {
            filterDatePicker.isHidden = !isdatePickerHealthLogVisible
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
//
        case datePickerHealthLogIndexPath:
                    return isdatePickerHealthLogVisible ? 217 : 0
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == filterLabelHealthLogIndexPath {
                    isdatePickerHealthLogVisible.toggle()
                } else {
                    return
                    }
                
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
