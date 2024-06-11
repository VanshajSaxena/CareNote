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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameSignup.layer.cornerRadius = 10.0
        usernameSignup.clipsToBounds = true
        
        personImageSignup.layer.cornerRadius = 10.0
        personImageSignup.clipsToBounds = true
        
        passwordSignup.layer.cornerRadius = 10.0
        passwordSignup.clipsToBounds = true
        
        passwordConfirm.layer.cornerRadius = 10.0
        passwordConfirm.clipsToBounds = true
        
        lockImageSignup.layer.cornerRadius = 10.0
        lockImageSignup.clipsToBounds = true
        

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
