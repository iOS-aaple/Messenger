//
//  HomeViewController.swift
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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var conversationArr = [String]()
    var chats = [Chat]()
    var userID = String()
    var chatMessagesArr = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchChats()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func fetchChats() {
       
        
        var db : DatabaseReference!
        db = Database.database().reference().child("Chats")
        
        db.observe(.childAdded) { snapshot, err in
           
            if let chats = snapshot.value as? NSDictionary {
                
                  let chatID = snapshot.key
                  let chatUsers = chats["Users"] as? NSDictionary
                  
                
                if let chatMessages = chats["Message"] as? NSDictionary {
                    let messages = chatMessages as! NSDictionary
                    self.convertToMessage(messages: messages)
                    
                } // chatMessages

              
                let usersInChat = User_(first: chatUsers!["first"] as! String, second: chatUsers!["seconde"] as! String)
                
                let newChat = Chat(id: chatID, message: self.chatMessagesArr, users: usersInChat) // convert from NSDictionary to Chat
               
                
                // filter th chats
                
                let users = chats["Users"] as! NSDictionary
                for user in users {
                    let userID = user.value as! String
                    if userID == Auth.auth().currentUser?.uid {
                        
                        self.chats.append(newChat)
                        self.chats.sort { chat1, chat2 in
                            return chat1.message[0].time > chat2.message[0].time
                        }
            
                        self.tableView.reloadData()
                       
                    }
                }
            } // end of chats
                
        } // end of observe

    } // end of fetchChats
    
    
    
    func convertToMessage(messages:NSDictionary){
        for message in messages {
            let mesg = message.value as! NSDictionary
            
            let mesgContent = Message(sendrID: mesg["senderID"] as! String, text: mesg["text"] as! String, time: mesg["time"] as! String)
           
            chatMessagesArr.append(mesgContent)
           
        }

    } // end of convertToMessage
    
    
    // MARK: -  Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return chats.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        // get users
        
        let userRef:DatabaseReference!
            userRef = Database.database().reference()
            userRef.child("users").observe(.value) { snopshot, err in
                
                let users = snopshot.value as! NSDictionary
                let userID = Auth.auth().currentUser!.uid
            
                for user in users {
                    
                    let cureentUserID = self.chats[indexPath.row].users.first == userID ? self.chats[indexPath.row].users.second : self.chats[indexPath.row].users.first
                    
                    let userContent = user.value as! NSDictionary
                    
                        if user.key as! String == cureentUserID {
                            cell.userName.text = userContent["fullName"] as? String
                    
                                // get profile image
                    
                                let storageRef : StorageReference!
                                    storageRef = Storage.storage().reference().child("\(userContent["imageProfile"] as! String)")
                                    storageRef.getData(maxSize:  5 * 1024 * 1024) { data, error in
                                        
                                            if error != nil {
                                                print("error")
                                                    }
                                                        else {
                                                                DispatchQueue.main.async {
                                                                    cell.conversationImage.image = UIImage(data: data!)
                                
                                                                } // end of DispatchQueue
                                                            }// end of else
                                                        }// end of getData
                                                    }
                                                } // end of for
                                        } // end of observe
        
          
            let timeFormat = DateFormatter()
                timeFormat.dateFormat = "hh:mm a"
            let time = Date()
            let chat = chats[indexPath.row]
            cell.lastMessage.text = chat.message[chat.message.count-1].text
            cell.hourLabel.text = timeFormat.string(from: time)
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sstoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let chatView = sstoryBoard.instantiateViewController(withIdentifier: "ChatView") as! ChatViewController
            chatView.chatID = chats[indexPath.row].id
            chatView.chatType = 1
            chatView.fromID = chats[indexPath.row].users.first == Auth.auth().currentUser?.uid ? chats[indexPath.row].users.first : chats[indexPath.row].users.second
            chatView.toID = chats[indexPath.row].users.first != Auth.auth().currentUser?.uid ? chats[indexPath.row].users.first : chats[indexPath.row].users.second
            chatView.modalPresentationStyle = .fullScreen
        
        present(chatView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



