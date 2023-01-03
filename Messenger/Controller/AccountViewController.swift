//
//  AccountViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore
import Firebase
import FirebaseAuth
import FirebaseStorage

class AccountViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //MARK: vars
    var name : String?
    var email : String?
    var password : String?
    var profilePhoto : Data?
    var userID = String()
    var userInfo = NSDictionary()
    var editMode = false

    //MARK: Connections
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordContiner: UIStackView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var errorMessage: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButtons()
        fetchData()
        editButton.layer.cornerRadius = 20 
    }
    
   
    
    // MARK: Actions
    
    @IBAction func profileImageAction(_ sender: Any) {
        getImage(type: UIImagePickerController.SourceType.photoLibrary)
    }
    
    
    @IBAction func editAction(_ sender: UIButton) {
        
        if editMode {
            disableButtons()
            sender.setTitle("Edit", for: .normal)
            sender.backgroundColor = .blue
            editMode = false
            sender.layer.cornerRadius = 20
            
            
        } else{
            enableButtons()
            sender.setTitle("Cancel", for: .normal)
            sender.backgroundColor = .red
            editMode = true
            sender.layer.cornerRadius = 20
        }
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        errorMessage.isHidden = true
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 5
        
        confirmPasswordTextField.layer.borderWidth = 0
        confirmPasswordTextField.layer.borderColor = UIColor.white.cgColor
        confirmPasswordTextField.layer.cornerRadius = 5
        
        
        if passwordTextField.text! == confirmPasswordTextField.text! {
            
            let updateUser = User(
                fullName: nameTextField.text! ,
                email: emailTextField.text!,
                password: passwordTextField.text!,
                profileImage: "", id: "\(userID)",phoneNumber: phoneNumberTextField.text!) // ther is problem her 
            
            // update the information in realtime database
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("users").child("\(userID)").setValue(["email":updateUser.email,"fullName":updateUser.fullName,"password":updateUser.password,"imageProfile":updateUser.profileImage,"phoneNumber":updateUser.phoneNumber])
            
            // update the information in Authentication
            
            let currentUser = Auth.auth().currentUser
            currentUser?.updateEmail(to: updateUser.email)
            currentUser?.updatePassword(to: updateUser.password)
            
            //alerm and logout
            
            let alert = UIAlertController(title: "Success", message: "You need to login again \n when you select ok will automatically signout", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: { action in
                self.logout()
            }))
            present(alert, animated: true)
        }
        
        else{
            errorMessage.isHidden = false
            passwordTextField.layer.borderWidth = 0.5
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderWidth = 0.5
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }
    } // saveAction()
    
    @IBAction func logoutAction(_ sender: Any) {
                logout()
            }
    
    // MARK: Functionality
    
    
    // Activation
    func enableButtons(){
        nameTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        confirmPasswordContiner.isHidden = false
        profileImageButton.isHidden = false
      //  profileImageButton.isUserInteractionEnabled = true
    }
    
    func disableButtons() {
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        confirmPasswordContiner.isHidden = true
        profileImageButton.isHidden = true
        errorMessage.isHidden = true
        //profileImageButton.isUserInteractionEnabled = false
    }
    
    func fetchData(){
        
        var db:DatabaseReference!
        db = Database.database().reference()
        db.child("users").child("\(userID)").observe(.value) { resualt in
            
            self.userInfo = resualt.value as! NSDictionary
            
            // fethc the data from storeage
            let storageRef = Storage.storage().reference().child("\(self.userInfo["imageProfile"] as! String)")
            storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                
                if error == nil {
                    self.profileImage.image = UIImage(data: data!)
                   
                }
            }
            
            
            DispatchQueue.main.async {
                self.nameTextField.text = self.userInfo["fullName"] as? String
                self.emailTextField.text = self.userInfo["email"] as? String
                self.passwordTextField.text = self.userInfo["password"] as? String
                self.phoneNumberTextField.text = self.userInfo["phoneNumber"] as? String
            }
        }
        
    } // fetchData()
    
    func logout(){
        
        let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginView = storyboard.instantiateViewController(withIdentifier: "Login")
                loginView.modalPresentationStyle = .fullScreen
                present(loginView, animated: true)
            }
            catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                    }
    } //logout()
    
    
    //MARK: Get Image Setup
    
    private func getImage(type : UIImagePickerController.SourceType){
        
        let photoPicker = UIImagePickerController()
            photoPicker.sourceType = .photoLibrary
            photoPicker.allowsEditing = true
            photoPicker.delegate = self
        present(photoPicker, animated: true)
        
    } //getImage()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {

                profileImage.image = image
                profileImage.contentMode = .scaleToFill
                profilePhoto = image.pngData()!

                }
                picker.dismiss(animated: true)
        
            } //imagePickerController
    
}
