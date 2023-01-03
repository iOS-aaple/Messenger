//
//  ViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//


import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController {
   

    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var errorMassage: UILabel!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var facbook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorMassage.isHidden = true
//        facbook.delegate = self
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
           }
    }

    // MARK: - Navigation
    
    @IBAction func login(_ sender: UIButton) {
        
        self.errorMassage.isHidden = true
        self.emailTextFiled.layer.borderWidth = 0.0
        self.passwordTextFiled.layer.borderWidth = 0.0
        self.emailTextFiled.layer.borderColor = UIColor.white.cgColor
        self.passwordTextFiled.layer.borderColor = UIColor.white.cgColor
        
        
        Auth.auth().signIn(withEmail: emailTextFiled.text!, password: passwordTextFiled.text!) { result, err in
            if err != nil {
                self.errorMassage.isHidden = false
                self.emailTextFiled.layer.borderWidth = 0.5
                self.passwordTextFiled.layer.borderWidth = 0.5
                self.emailTextFiled.layer.borderColor = UIColor.red.cgColor
                self.passwordTextFiled.layer.borderColor = UIColor.red.cgColor
                
            } else{
               
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeView = storyboard.instantiateViewController(withIdentifier: "TabBar") as! TabBarView
               let account = homeView.viewControllers![2] as! AccountViewController
                account.userID = "\(result!.user.uid)"
                homeView.modalPresentationStyle = .fullScreen
                self.present(homeView, animated: true)
            }
        }
    }
    
    @IBAction func goToSingupView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let singupView = storyboard.instantiateViewController(withIdentifier: "SingupView")
        singupView.modalPresentationStyle = .fullScreen
        present(singupView, animated: true)
    }
    
    @IBAction func goToLoginView(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let forgotPassowrdView = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordView")
        forgotPassowrdView.modalPresentationStyle = .formSheet
        present(forgotPassowrdView, animated: true)
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
       
           let loginManager = LoginManager()
           
           if let _ = AccessToken.current {
            
               loginManager.logOut()
               
           } else {
               
               loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                   guard error == nil else {
                       // Error occurred
                       print(error!.localizedDescription)
                       return
                   }
                   // Check for cancel
                   guard let result = result, !result.isCancelled else {
                       print("User cancelled login")
                       return
                   }
               
                   Profile.loadCurrentProfile { (profile, error) in
                     
                   }
               }
           }
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
    }
    
}
