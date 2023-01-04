//
//  ChatViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage
class ChatViewController: UIViewController {
    
    //MARK: Connections
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messagesTable: UICollectionView!
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    
    //MARK: Vars
    var messages = [NSDictionary]()
    var receiver = String()
    var chatID = String()
    var fromID = String()
    var toID = String() 
    var userName = String()
    var chatType = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTable.dataSource = self
        messagesTable.delegate = self
        
        observeMessage()
        getReceiverInfo(userID: toID)
    }
    
    func  getReceiverInfo(userID:String) {
        var db: DatabaseReference!
            db = Database.database().reference().child("users")
            db.child("\(userID)").observeSingleEvent(of: .value) { snapshot , error in
                
                if let user = snapshot.value as? NSDictionary {
                
                    //get profile image
                
                    var storageRef : StorageReference!
                        storageRef = Storage.storage().reference().child("\(user["imageProfile"] as! String)")
                        storageRef.getData(maxSize:  5 * 1024 * 1024) { data, error in
                            
                                if error != nil {
                                    print("error")
                                }
                                    else {
                                            DispatchQueue.main.async {
                                                self.userNameLabel.text = user["fullName"] as? String
                                                self.profileImage.image = UIImage(data: data!)
                                                }
                                            }
                                        } // end of getData()
           
                    } // end of user
                }
    } // end of getReceiverInfo

   
    
    func observeMessage() {
        
        if chatType == 0 {
    
            let chatId = UUID()
            var setUser: DatabaseReference!
                setUser = Database.database().reference().child("Chats").child("\(chatId)").child("Users")
                setUser.setValue(["first":"\(receiver)","seconde":"\(Auth.auth().currentUser!.uid)"])
            
            
            var setMessage: DatabaseReference!
                setMessage = Database.database().reference().child("Chats").child("\(chatId)").child("Message")
          
            self.chatID = "\(chatId)"
           
            
        } else {
          
            var ref:DatabaseReference!
                ref  = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
                ref.observe(.childAdded) { snapshot , err in
              
                    if let message = snapshot.value as? NSDictionary {
                    
                        self.messages.append(message)
                        self.messagesTable.reloadData()
                    
                } // end of message
                    
            } // end of observe()
            
        } // end of else
     
    } // end observeMessage
    
    
    //MARK: Acions
    
    @IBAction func backToHome(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    @IBAction func sendAction(_ sender: Any) {
    
        if chatType == 0 {
            
            let sendrID = Auth.auth().currentUser?.uid
            let ref: DatabaseReference!
                ref = Database.database().reference().child("Chats").child("\(chatID)").child("Message").child("\(UUID())")
                ref.setValue(["senderID":"\(sendrID!)","text" : msgTextField.text!,"time":"\(Date())"])
            chatType = 1
            msgTextField.text = ""
            
        } else{
            let sendrID = Auth.auth().currentUser?.uid
            let ref: DatabaseReference!
                ref = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
            let childRef = ref.childByAutoId()
                childRef.updateChildValues(["senderID":"\(sendrID!)","text" : msgTextField.text!,"time":"\(Date())"])
            msgTextField.text = ""
        }
       
    } // sendAction

    

}
extension ChatViewController:UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let currentID = Auth.auth().currentUser?.uid
            let senderID = messages[indexPath.row]["senderID"] as! String
            let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
                
            let date = timeFormatter.date(from: messages[indexPath.row]["time"] as! String) // convert from String to Date
        
            timeFormatter.dateFormat = date == Date() ? "hh:mm a" : "MMM d, hh:mm a"
      
        let cell = messagesTable.dequeueReusableCell(withReuseIdentifier: "msgCell", for: indexPath) as! ChatCollectionViewCell
       
            cell.messageText.text = "\(messages[indexPath.row]["text"] as! String)"
            cell.messageTime.text = "\(timeFormatter.string(from: date!))"
            cell.messageBody.backgroundColor = currentID == senderID ? UIColor(red: 0.15, green: 0.59, blue: 0.75, alpha: 1.00) : UIColor.gray
            cell.messageBody.layer.cornerRadius = 10
            cell.messageBody.widthAnchor.constraint(lessThanOrEqualTo: cell.widthAnchor).isActive = true
            cell.messageBody.heightAnchor.constraint(lessThanOrEqualTo: cell.heightAnchor).isActive = true
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }

}
