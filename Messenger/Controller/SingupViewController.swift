//
//  SingupViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 29/12/2022.
//


import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase
class SingupViewController: UIViewController {

    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var confirmPassswordTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var fullNameTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        errorMessage.isHidden = true
        passwordTextFiled.layer.cornerRadius = 10
        confirmPassswordTextFiled.layer.cornerRadius = 10
    }
    

    
    // MARK: - Navigation

    @IBAction func signup(_ sender: Any) {
        if passwordTextFiled.text != confirmPassswordTextFiled.text{
            errorMessage.isHidden = false
            passwordTextFiled.layer.borderColor = UIColor.red.cgColor
            passwordTextFiled.layer.borderWidth = 0.5
            passwordTextFiled.layer.cornerRadius = 10
            confirmPassswordTextFiled.layer.borderColor = UIColor.red.cgColor
            confirmPassswordTextFiled.layer.cornerRadius = 10
            confirmPassswordTextFiled.layer.borderWidth = 0.5
        } else{
            // signup
            
            Auth.auth().createUser(withEmail: emailTextFiled.text!, password: passwordTextFiled.text!) { result, err in
                if  err != nil {
                    
                    self.errorMessage.isHidden = false
                    self.errorMessage.text = "⚠ \(err!.localizedDescription)"
                    
                }
                else{
                    
                  // create user info into database
                    let newUser = User(fullName: self.fullNameTextFiled.text!, email: self.emailTextFiled.text!, password: self.passwordTextFiled.text!, profileImage: "",id: "\(result!.user.uid)")
                    var ref: DatabaseReference!
                     ref = Database.database().reference()
                     ref.child("users").child(newUser.id).setValue(["email":newUser.email,"fullName":newUser.fullName,"password":newUser.password,"imageProfile":""])
                    
                    // send Notification
                    
                    
                  // back to login page
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    
    @IBAction func backToLogin(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    // MARK: - Notification
    
    
//    func sendNotification(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) {  authorized, error in
//            if authorized {
//                    self.generateNotification(name: self.fullNameTextFiled.text!)
//            }
//        } // end of UNUserNotificationCenter
//    }
    
    func generateNotification(name:String){
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Welcome to Messenger"
        notificationContent.body = "Dear \(name) thank you to join us "
        notificationContent.sound = .default
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(0), repeats: false)
        
        let request = UNNotificationRequest(identifier: "test", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request)
        
    } // end of generateNotification
    
    
}
