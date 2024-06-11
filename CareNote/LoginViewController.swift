//
//  LoginViewController.swift
//  CareNote
//
//  Created by Batch-2 on 11/06/24.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainTabController")
         

         if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
             print("got here")
             sceneDelegate.window?.rootViewController = mainViewController
         }
    }
    
}
