//
//  PeopleViewController.swift
//  Messenger
//
//  Created by Munira on 28/12/2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage
class PeopleViewController: UIViewController {

    var users = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.dataSource = self
        tableView.delegate = self
        
        fetshData()
    }
    
    
   func fetshData(){
       
       var dbRef:DatabaseReference!
            dbRef = Database.database().reference()
       
            dbRef.child("users").observe(.value) { resualt,err in
                let currentUser = Auth.auth().currentUser?.uid
                let users = resualt.value as! NSDictionary
          
                    for user in users{
                        let userID = "\(user.key)"
             
                        if userID != currentUser {
                           let user_ = user.value as! NSDictionary
                          
                           let newUser = User(fullName: user_["fullName"] as! String, email: user_["email"] as! String, password: user_["password"] as! String, profileImage: user_["imageProfile"] as! String , id: "\(user.key)", phoneNumber: user_["phoneNumber"] as! String)
                            
                           self.users.append(newUser)
                       }

                    }
                
           DispatchQueue.main.async {
               self.tableView.reloadData()
           } // end of DispatchQueue
  
                
       } // end of observe
    } //end of fetshData
    
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! peopleCell
        
        // get profile image  from the storage
        let storageRef : StorageReference!
            storageRef = Storage.storage().reference().child("\(users[indexPath.row].profileImage)")
            storageRef.getData(maxSize:  5 * 1024 * 1024) { data, error in
                
                if error != nil {
                print("error")
                    }
                else {
                    DispatchQueue.main.async {
                        cell.friendImage.image = UIImage(data: data!)
                    }
                }
        } // end of getData
        
        cell.friendName.text = users[indexPath.row].fullName
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatView = storyboard.instantiateViewController(withIdentifier: "ChatView") as! ChatViewController
     
            
        var chatRef : DatabaseReference!
            chatRef = Database.database().reference()
            chatRef.child("Chats").observe(.value){ result, err in
                let chats = result.value as! NSDictionary
           
                    for chat in chats {
                        let chatContent = chat.value as! NSDictionary
                        let usersInChat = chatContent["Users"] as! NSDictionary
                        let userID = Auth.auth().currentUser!.uid
                        
                            for userInChat in usersInChat {
                                    if userInChat.value as! String == userID {
                        
                                        chatView.chatType = 1
                                        chatView.chatID = chat.key as! String
                                        chatView.fromID = userID
                                        chatView.toID =  self.users[indexPath.row].id
                     
                                    }
                                        else {
                        
                                            chatView.fromID = "\(userID)"
                                            chatView.toID = self.users[indexPath.row].id
                                            chatView.receiver = self.users[indexPath.row].id
                                            chatView.chatType = 0
                     
                                        }
                                    }
                                }
           
                        if !chatView.isBeingPresented {
                            chatView.modalPresentationStyle = .fullScreen
                            self.present(chatView, animated: false)
                            }
            } // end of observe
        }
    
}
