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

class AccountViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //MARK: vars
    var name : String?
    var email : String?
    var password : String?
    var profilePhoto : Data?
    

    //MARK: Connections
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButtons()
    }
    
    // Activation
    func enableButtons(){
        nameTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        profileImageButton.isUserInteractionEnabled = true
    }
    
    func disableButtons() {
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        profileImageButton.isUserInteractionEnabled = false
    }
    
    
    // MARK: Actions
    
    @IBAction func profileImageAction(_ sender: Any) {
        getImage(type: UIImagePickerController.SourceType.photoLibrary)
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        enableButtons()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        let updateUser = User(fullName: nameTextField.text! , email: emailTextField.text!, password: passwordTextField.text!, profileImage: "\(profilePhoto!)", id: "HWYZd0V4n1ONWVXNzZ8Rzyc2DBI3")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child("HWYZd0V4n1ONWVXNzZ8Rzyc2DBI3").setValue(["email":updateUser.email,"fullName":updateUser.fullName,"password":updateUser.password,"imageProfile":updateUser.profileImage])
        print("اي حاجه")

        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
    }
    
    
    func update(){
        
    }
    
    //MARK: Get Image Setup
    
    private func getImage(type : UIImagePickerController.SourceType){
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = .photoLibrary
        photoPicker.allowsEditing = true
        photoPicker.delegate = self
        present(photoPicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {

                profileImage.image = image
                profileImage.contentMode = .scaleToFill
                profilePhoto = image.pngData()!

            }
        picker.dismiss(animated: true)
        }
    
    

}
