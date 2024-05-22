//
//  EditMedicationTableViewController.swift
//  CareNote
//
//  Created by Sameer-Vermaon 21/05/24.
//

import UIKit

class EditMedicationTableViewController: UITableViewController {

    var medicine : [Medicine] = []
    
    
    
    @IBOutlet var MedicineNameTextField: UITextField!
    @IBOutlet var DoseageTextField: UITextField!
    @IBOutlet var FrequencyPopButton: UIButton!
    
    @IBOutlet var TimePopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpButton()
        setTimePopButton()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setPopUpButton(){
        let optionClosure = {(action : UIAction) in
        print(action.title)}
//      Frequency = action.title
        FrequencyPopButton.menu = UIMenu (children : [
        UIAction(title : "Select", state :.on, handler: optionClosure),
        UIAction(title : "Everyday", handler: optionClosure),
        UIAction(title : "Once A Week", handler: optionClosure),
        UIAction(title : "Alternate Days", handler: optionClosure),
        UIAction(title : "Custom", handler: optionClosure)])
        FrequencyPopButton.showsMenuAsPrimaryAction = true
        FrequencyPopButton.changesSelectionAsPrimaryAction = true
        
    }
    func setTimePopButton(){
        let optionClosure = {(action : UIAction) in
        print(action.title)}
        TimePopButton.menu = UIMenu (children : [
        UIAction(title : "Select", state :.on, handler: optionClosure),
        UIAction(title : "Before Breakfast", handler: optionClosure),
        UIAction(title : "After Breakfast", handler: optionClosure),
        UIAction(title : "Before Lunch", handler: optionClosure),
        UIAction(title : "After Lunch", handler: optionClosure),
        UIAction(title : "Before Dinner", handler: optionClosure),
        UIAction(title : "After Dinner", handler: optionClosure)])
        TimePopButton.showsMenuAsPrimaryAction = true
        TimePopButton.changesSelectionAsPrimaryAction = true
        
    }
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let name = MedicineNameTextField.text ?? ""
        let dose = DoseageTextField.text ?? ""
//        let frequency = FrequencyPopButton.
        print("Done Buton tapped")
    }
    
    // MARK: - Table view data source

    
    

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
