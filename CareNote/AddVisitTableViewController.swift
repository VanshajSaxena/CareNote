//
//  AddVisitTableViewController.swift
//  CareNote
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class AddVisitTableViewController: UITableViewController {
    
    
    @IBOutlet var documnetPopButton: UIButton!
    @IBOutlet var addVisitDateLabel: UILabel!
    @IBOutlet var addVisitDatePicker: UIDatePicker!
    
    var addVisitDateLabelIndexPath = IndexPath(row: 0, section: 0)
    var addVisitDatePickerIndexPath = IndexPath(row: 1, section: 0)
    
    var isAddVisitDatePickerVisible:Bool = false {
        didSet {
            addVisitDatePicker.isHidden = !isAddVisitDatePickerVisible
        }
    }
    
    struct addVisit {
        var date : Date
        var document : String
        var note : String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDocumentPopButton()
        updateDateView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateDateView() {
        addVisitDateLabel.text = addVisitDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func setDocumentPopButton(){
        let optionClosure = {(action : UIAction) in
        print(action.title)}
        documnetPopButton.menu = UIMenu (children : [
        UIAction(title : "Document Type", state :.on, handler: optionClosure),
        UIAction(title : "Doctor Visit", handler: optionClosure),
        UIAction(title : "Lab Report", handler: optionClosure)])
        documnetPopButton.showsMenuAsPrimaryAction = true
        documnetPopButton.changesSelectionAsPrimaryAction = true
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case addVisitDatePickerIndexPath:
            return isAddVisitDatePickerVisible ? 217 : 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == addVisitDateLabelIndexPath {
            isAddVisitDatePickerVisible.toggle()
        } else {
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func addVisitDateSelected(_ sender: UIDatePicker) {
        updateDateView()
    }
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }

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
