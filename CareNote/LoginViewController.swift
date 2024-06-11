//
//  LoginViewController.swift
//  CareNote
//
//  Created by Batch-2 on 11/06/24.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var personImage: UIImageView!
    @IBOutlet var lockImage: UIImageView!
    @IBOutlet var forgotPassword: UIButton!
    @IBOutlet var login: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.layer.cornerRadius = 10.0
        username.clipsToBounds = true
        
        password.layer.cornerRadius = 10.0
        password.clipsToBounds = true
        
        personImage.layer.cornerRadius = 10.0
        personImage.clipsToBounds = true
        
        lockImage.layer.cornerRadius = 10.0
        lockImage.clipsToBounds = true

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
