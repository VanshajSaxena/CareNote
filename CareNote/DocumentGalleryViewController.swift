//
//  DocumentGalleryViewController.swift
//  CareNote
//
//  Created by Batch-2 on 03/06/24.
//

import UIKit

class DocumentGalleryViewController: UIViewController {

    @IBOutlet var documentGalleryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        documentGalleryTableView.delegate = self
        documentGalleryTableView.dataSource = self

        // Do any additional setup after loading the view.
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

extension DocumentGalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Document Gallery didSelectRowAt")
    }
}

extension DocumentGalleryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Document", for: indexPath)
        cell.textLabel?.text = "Document Gallery \(indexPath)"
        return cell
    }
}
