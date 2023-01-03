//
//  ViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//


import UIKit
import FirebaseAuth
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var errorMassage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorMassage.isHidden = true
        
      
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
    
    
}
