//
//  MedMinderTableViewController.swift
//  CareNote
//
//  Created by Sameer-Verma on 20/05/24.
//

import UIKit

class MedMinderTableViewController: UITableViewController {
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "Medminder"
        super.tabBarItem.image = UIImage(systemName: "pills")
        super.tabBarItem.selectedImage = UIImage(systemName: "pills.fill")
    }
    
    //UI Outlet for the date filter of the application
    
    @IBOutlet var filterDateLabel: UILabel!
    @IBOutlet var filterDatePicker: UIDatePicker!
//---------------------------------------------------------------
    
    // Here we are saving the index path of the date label and date Picker Value
    var filterDateLabelIndexPath = IndexPath(row: 0, section: 0)
    var filterDatePickerIndexPath = IndexPath(row: 1, section: 0)

    // this is the Variable used for the checking that is the Date Picker is visible or not
    var isFilterDatePickerVisible:Bool = false{
        didSet{
            filterDatePicker.isHidden = !isFilterDatePickerVisible
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
//
        case filterDatePickerIndexPath:
                    return isFilterDatePickerVisible ? 217 : 0
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == filterDateLabelIndexPath {
                    isFilterDatePickerVisible.toggle()
                } else {
                    return
                    }
                
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
// ----------  VIEW DID LOAD ------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let midnightToday = Calendar.current.startOfDay(for: Date())
//        FilterDatePicker.minimumDate = midnightToday
        updateDateview() // calling the function when application just open
        
        addGradientBackground()
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()

        // Adjust the frame to cover the entire bounds of the view
        gradientLayer.frame = self.view.bounds

        let colour1 = UIColor(red: 0x66 / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        let colour2 = UIColor(red: 0x66 / 255.0, green: 0xCC / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        
        gradientLayer.colors = [colour1.cgColor, colour2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Create a UIView to hold the gradient layer
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Set the background view of the tableView
        self.tableView.backgroundView = backgroundView
    }



    
    // this is the function which is used to update the Filter Date Label according to the Date Picker
    
//**************************************************************************************
    
// ------------------ DATE PICKER ------------------------------
    func updateDateview(){
        filterDateLabel.text = filterDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
    }
    
// Filter date picker Action Outlet -- filterDateChanged -- Whenever Date changed
    
    @IBAction func filterDateChanged(_ sender: UIDatePicker) {
        updateDateview()
        print("date \(filterDatePicker.date.formatted(date: .abbreviated, time: .omitted))")
    }
    
// **************************************************************************************
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return
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
