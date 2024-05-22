//
//  ViewController.swift
//  CareNote
//
//  Created by Sameer-Verma on 20/05/24.
//

import UIKit

class ViewController: UIViewController {
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "doc.text.image")
        super.tabBarItem.selectedImage = UIImage(systemName: "doc.text.image.fill")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

