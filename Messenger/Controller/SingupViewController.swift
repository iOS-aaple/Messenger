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
import FirebaseStorage
class SingupViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    @IBOutlet weak var addProfileImage: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var confirmPassswordTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var fullNameTextFiled: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    var userImage = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        errorMessage.isHidden = true
        passwordTextFiled.layer.cornerRadius = 10
        confirmPassswordTextFiled.layer.cornerRadius = 10
        profileImage.isHidden = true
    }
    
    // MARK: - Action

    @IBAction func addProfileImage(_ sender: UIButton) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {

            profileImage.image = image
            profileImage.contentMode = .scaleToFill
            userImage = image.pngData()!
            profileImage.isHidden = false
            addProfileImage.isHidden = true
        }
        picker.dismiss(animated: true)
    }
    
    func registerUserIntoDatabase() {
        
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
                    
                    // upload image to database
                    
                    let storegRef : StorageReference!
                    storegRef = Storage.storage().reference().child("\(UUID()) .png")
                    print(self.userImage)
                    storegRef.putData(self.userImage,metadata: nil) { storeg, error in
                        
                        if error != nil {
                            print("\(error!.localizedDescription)")
                            
                        } else{
                            
                           
                            // create user info into database
                              let newUser = User(fullName: self.fullNameTextFiled.text!, email: self.emailTextFiled.text!, password: self.passwordTextFiled.text!, profileImage: "",id: "\(result!.user.uid)",phoneNumber: self.phoneNumber.text!)
                              
                              var ref: DatabaseReference!
                               ref = Database.database().reference()
                              ref.child("users").child(newUser.id).setValue(["email":newUser.email,"fullName":newUser.fullName,"password":newUser.password,"imageProfile":"\(self.userImage)","phoneNumber":newUser.phoneNumber])
                        }
                        
                    }

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
