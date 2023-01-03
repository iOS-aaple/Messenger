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
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messagesTable: UICollectionView!
    //MARK: Connections
    @IBOutlet weak var msgTextField: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
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
        // Do any additional setup after loading the view.
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
                }
           
                    
            

            }
        }
    }

    @IBAction func sendAction(_ sender: Any) {
        
        let sendrID = Auth.auth().currentUser?.uid
        let ref: DatabaseReference!
            
      //  ref = Database.database().reference().child("Chats").child("\(UUID())").child("Users")
       // ref.setValue(["first":"\(receiver)","seconde":"\(Auth.auth().currentUser?.uid)"])
      //  ref.setValue(["Message":"","Users":""])
        if chatType == 0 {
            ref = Database.database().reference().child("Chats").child("\(chatID)").child("Message").child("\(UUID())")
            ref.setValue(["senderID":"\(sendrID!)","text" : msgTextField.text!,"time":"\(Date())"])
            chatType = 1
            
        } else{
            ref = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
            let childRef = ref.childByAutoId()
            childRef.updateChildValues(["senderID":"\(sendrID!)","text" : msgTextField.text!,"time":"\(Date())"])
            
        }
        msgTextField.text = ""
    }
    
    func observeMessage() {
        
        if chatType == 0 {
            
            let chatID = UUID()
   
            var setUser: DatabaseReference!
                setUser = Database.database().reference().child("Chats").child("\(chatID)").child("Users")
                setUser.setValue(["first":"\(receiver)","seconde":"\(Auth.auth().currentUser!.uid)"])
            
            
            var setMessage: DatabaseReference!
            setMessage = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
          //  setMessage.setValue(["senderID":"","text" : "","time":""])
            
            
            chatType = 1
            self.chatID = "\(chatID)"
            
        } else {
            
            var ref:DatabaseReference!
            ref  = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
            ref.observe(.childAdded) { snapshot , err in
                print("❤️")
                
                if let message = snapshot.value as? NSDictionary {
                    print("❤️")
                    print(message)
                    self.messages.append(message)
//                    self.messagesTable.scrollToItem(at: IndexPath(index: self.messages.count), at: .bottom, animated: true)
                    self.messagesTable.reloadData()
                    
                    print(self.messages)
                }
                    
            }
            
        }
     
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
//    func textFieldShouldReturn(textfield : UITextField)-> Bool{
//        handleSend()
//       return true
//    }
    

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
                
        let date = timeFormatter.date(from: messages[indexPath.row]["time"] as! String)
        
        timeFormatter.dateFormat = "hh:mm a"
        print(timeFormatter.string(from: date!))

        let cell = messagesTable.dequeueReusableCell(withReuseIdentifier: "msgCell", for: indexPath) as! ChatCollectionViewCell
        //cell.text.text = "\(messages[indexPath.row]["text"] as! String)"
     //
            
        cell.messageText.text = "\(messages[indexPath.row]["text"] as! String)"
        cell.messageTime.text = "\(timeFormatter.string(from: date!))"
        //cell.transform =  currentID == senderID ?  CGAffineTransform(scaleX: -1, y: 1) : CGAffineTransform(scaleX: 1, y: 1)
        //cell.semanticContentAttribute =  currentID != senderID ? .forceLeftToRight : .unspecified
      //  cell.semanticContentAttribute = .forceRightToLeft
      //  cell.messageBody.layer.frame.size.height = cell.messageText.frame.height + 2
      //  cell.messageBody.layer.frame.size.width = cell.frame.width / 2.5
        cell.messageBody.backgroundColor = currentID == senderID ? UIColor(red: 0.15, green: 0.59, blue: 0.75, alpha: 1.00) : UIColor.gray
        cell.messageBody.layer.cornerRadius = 10
       
        cell.messageBody.widthAnchor.constraint(lessThanOrEqualTo: cell.widthAnchor).isActive = true
        cell.messageBody.heightAnchor.constraint(lessThanOrEqualTo: cell.heightAnchor).isActive = true
//        cell.messageBody.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        
       
        //cell.messageBody.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
//        cell.messageBody.heightAnchor.constraint(lessThanOrEqualTo: cell.heightAnchor).isActive = true 
//        messagesTable.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: "msgCell")
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }

}
