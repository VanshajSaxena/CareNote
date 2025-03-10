//
//  SignupViewController.swift
//  CareNote
//
//  Created by Batch-2 on 11/06/24.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var usernameSignup: UITextField!
    @IBOutlet var personImageSignup: UIImageView!
    @IBOutlet var passwordSignup: UITextField!
    @IBOutlet var passwordConfirm: UITextField!
    @IBOutlet var lockImageSignup: UIImageView!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var backgroundSignup: UITextField!
    @IBOutlet var backgroundPassSignup: UITextField!
    @IBOutlet var backgroundPass2Signup: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameSignup.layer.cornerRadius = 8.0
        usernameSignup.clipsToBounds = true
        
        personImageSignup.layer.cornerRadius = 8.0
        personImageSignup.clipsToBounds = true
        
        passwordSignup.layer.cornerRadius = 8.0
        passwordSignup.clipsToBounds = true
        
        passwordConfirm.layer.cornerRadius = 8.0
        passwordConfirm.clipsToBounds = true
        
        lockImageSignup.layer.cornerRadius = 8.0
        lockImageSignup.clipsToBounds = true
        
        backgroundSignup.layer.cornerRadius = 8.0
        backgroundSignup.clipsToBounds = true
        
        backgroundPassSignup.layer.cornerRadius = 8.0
        backgroundPassSignup.clipsToBounds = true
        
        backgroundPass2Signup.layer.cornerRadius = 8.0
        backgroundPass2Signup.clipsToBounds = true

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
