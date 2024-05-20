////
////  TimeLineViewController.swift
////  CareNote
////
////  Created by Batch-2 on 20/05/24.
////
//
//import UIKit
//
//class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    var timelineEntries: [TimelineEntry] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return timelineEntries.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath) as! TimelineEntryCell
//        
//        let entry = timelineEntries[indexPath.row]
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
