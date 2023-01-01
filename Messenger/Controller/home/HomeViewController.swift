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
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var conversationArr = [String]()
//   let users = [User]()
    var chats = [Chat]()
    var userID = String()
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
                  let chatMessages = chats["Message"] as! NSDictionary
                  let chatUsers = chats["Users"] as! NSDictionary
                  var chatMessagesArr = [Message]()
                
                    // convert messages to Message
                for chatMesssage in chatMessages {
                    let message = chatMesssage.value as! NSDictionary
                    let mess = Message(sendrID: message["senderID"] as! String, text: message["text"] as! String, time: message["time"] as! String)
                    
                    chatMessagesArr.append(mess)
                   
                }
                
                let usersInChat = User_(first: chatUsers["first"] as! String, second: chatUsers["seconde"] as! String)
                
                let newChat = Chat(id: chatID, message: chatMessagesArr, users: usersInChat)
               
                // filter th chats
                
                let users = chats["Users"] as! NSDictionary
                for user in users {
                    let userID = user.value as! String
                    if userID == Auth.auth().currentUser?.uid {
                        
                        self.chats.append(newChat)
                        self.chats.sort { chat1, chat2 in
                            return chat1.message[0].time > chat2.message[0].time
                        }
                        print("📕📕📕📕📕📕")
                        
                        print(self.chats[0].message.last!)
                        print("📕📕📕📕📕📕")
                        print(self.chats[0].message.count)
                        self.tableView.reloadData()
                       
                    }
                }
            }
                
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return chats.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell

        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "hh:mm a"
        let time = Date(timeIntervalSince1970: Double(chats[indexPath.row].message.last!.time)!)
        let chat = chats[indexPath.row]
        cell.userName.text = chat.users.first
        cell.lastMessage.text = chat.message[chat.message.count-1].text
        cell.hourLabel.text = timeFormat.string(from: time)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sstoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let chatView = sstoryBoard.instantiateViewController(withIdentifier: "ChatView") as! ChatViewController
        chatView.chatID = chats[indexPath.row].id
        chatView.fromID = chats[indexPath.row].users.first == Auth.auth().currentUser?.uid ? chats[indexPath.row].users.first : chats[indexPath.row].users.second
        chatView.toID = chats[indexPath.row].users.first != Auth.auth().currentUser?.uid ? chats[indexPath.row].users.first : chats[indexPath.row].users.second  
        chatView.modalPresentationStyle = .fullScreen
        present(chatView, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



