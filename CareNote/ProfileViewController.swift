//
//  ProfileViewController.swift
//  CareNote
//
//  Created by Batch-2 on 20/05/24.
//

import UIKit

class ProfileViewController: UIViewController {
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        super.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
