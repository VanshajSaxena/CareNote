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
        super.tabBarItem.title = "Profile"
        super.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        super.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addGradientBackground()
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let colour1 = UIColor(red: 0x66 / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        let colour2 = UIColor(red: 0x66 / 255.0, green: 0xCC / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
        
        gradientLayer.colors = [colour1.cgColor, colour2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
