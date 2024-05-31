//
//  EditMedicationTableViewController.swift
//  CareNote
//
//  Created by Sameer-Verma on 21/05/24.
//

import UIKit

class EditMedicationTableViewController: UITableViewController {

    var medicine : [Medicine] = []
    
    
    @IBOutlet var doneButtonTapped_Outlet: UIBarButtonItem!
    
    @IBOutlet var medicineNameTextField: UITextField!
    @IBOutlet var dosageTextField: UITextField!
    @IBOutlet var frequencyPopButton: UIButton!
    @IBOutlet var timePopButton: UIButton! //used for the time pop up button
    
    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var notificationSwitch: UISwitch!
    
    @IBOutlet var reminderModeLabel: UILabel!
    @IBOutlet var reminderMePopButton: UIButton! //used for hte reminder pop up buttom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrequencyPopUpButton()
        setTimePopButton()
        setReminderMePopButton()
        updateSaveButtonState()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Variable Declared to store the values of the pop up button items
    var frequencySelected : String = ""
    var slotTimeSelected : String = ""
    var reminderModeSelected : String = ""
    
    func setFrequencyPopUpButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.frequencySelected = "\(action.title)"
            
            }
        frequencyPopButton.menu = UIMenu (children : [
        UIAction(title : "Select", state :.on, handler: optionClosure),
        UIAction(title : "Everyday", handler: optionClosure),
        UIAction(title : "Once A Week", handler: optionClosure),
        UIAction(title : "Alternate Days", handler: optionClosure),
        UIAction(title : "Custom", handler: optionClosure)])
        frequencyPopButton.showsMenuAsPrimaryAction = true
        frequencyPopButton.changesSelectionAsPrimaryAction = true
        
    }
    func setTimePopButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.slotTimeSelected = "\(action.title)"
        }
        timePopButton.menu = UIMenu (children : [
        UIAction(title : "Select", state :.on, handler: optionClosure),
        UIAction(title : "Before Breakfast", handler: optionClosure),
        UIAction(title : "After Breakfast", handler: optionClosure),
        UIAction(title : "Before Lunch", handler: optionClosure),
        UIAction(title : "After Lunch", handler: optionClosure),
        UIAction(title : "Before Dinner", handler: optionClosure),
        UIAction(title : "After Dinner", handler: optionClosure)])
        timePopButton.showsMenuAsPrimaryAction = true
        timePopButton.changesSelectionAsPrimaryAction = true
    }
    
    func setReminderMePopButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.reminderModeSelected = "\(action.title)"
            }
        reminderMePopButton.menu = UIMenu (children : [
        UIAction(title : "Select", state :.on, handler: optionClosure),
        UIAction(title : "Silent", handler: optionClosure),
        UIAction(title : "Vibrate", handler: optionClosure)])
        reminderMePopButton.showsMenuAsPrimaryAction = true
        reminderMePopButton.changesSelectionAsPrimaryAction = true
        
    }
//    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
//        let medicineName = medicineNameTextField.text ?? ""
//        let dose = dosageTextField.text ?? ""
//        let note = noteTextField.text ?? ""
//        let notifiaction = notificationSwitch.isOn
//
//        print("Done Buton tapped")
//        print(medicineName)
//        print(dose)
//        print(frequencySelected)
//        print(slotTimeSelected)
//        print(note)
//        print(notifiaction)
//        print(reminderModeSelected)
//        
//        print("Medicine name is \(medicineName) and number of doasages is \(dose) also the Frequency is \(frequencySelected)")
//        
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSaveButtonState()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func popUPButtonChanged(_ sender: UIButton) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let medicineName = medicineNameTextField.text ?? ""
        let dose = dosageTextField.text ?? ""
//        let note = noteTextField.text ?? ""
        let frequency = frequencySelected
        let slot = slotTimeSelected
//        let notifiaction = notificationSwitch.isOn
        doneButtonTapped_Outlet.isEnabled = !medicineName.isEmpty && !dose.isEmpty && frequency != "Select" && slot != "Select"
    }
    
    
//--------------------------- ****************************************************************************** ---------------------------
    
    var allowNotificationIndexPath = IndexPath(row: 0, section: 2)
    var reminderIndexPath = IndexPath(row: 1, section: 2)
    
    var isReminderVisible:Bool = false{
        didSet{
            reminderModeLabel.isHidden = !isReminderVisible
            reminderMePopButton.isHidden = !isReminderVisible
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
//
        case reminderIndexPath:
            if isReminderVisible{
                return 44 
            }
            else{
                return 0
            }
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == allowNotificationIndexPath {
//                    isReminderVisible.toggle()//
//            isReminderVisible = true
            isReminderVisible.toggle()
                } else {
                    return
                    }
                
        tableView.beginUpdates()
        tableView.endUpdates()
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

//********************** ------------------------------------------ ************************************** -------------------------------
    // cancel button Action
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
