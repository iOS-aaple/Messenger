//
//  AccountViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//

import UIKit

class AccountViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: vars
    var name : String?
    var email : String?
    var password : String?
    var phone : String?
    var image : UIImage?
    var birthDate : Date?
    

    //MARK: Connections
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
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
        birthDatePicker.isUserInteractionEnabled = true
        phoneTextField.isUserInteractionEnabled = true
        profileImageButton.isUserInteractionEnabled = true
    }
    
    func disableButtons() {
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        birthDatePicker.isUserInteractionEnabled = false
        phoneTextField.isUserInteractionEnabled = false
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
        nameTextField.text = name
        emailTextField.text = email
        passwordTextField.text = password
//        birthDatePicker.date = birthDate
        phoneTextField.text = phone
        profileImage.image = image
        
    }
    
    
    //MARK: Get Image Setup
    
    private func getImage(type : UIImagePickerController.SourceType){
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = type
        photoPicker.allowsEditing = true
       // photoPicker.delegate = self
        present(photoPicker, animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else{
            print("IMAGE NOT FOUND")
            return
        }
        profileImage.image = image
    }
}
