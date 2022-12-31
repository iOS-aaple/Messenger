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
    var users = [NSDictionary]()
    var userID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func fetchUser() {
        //        FIRDatabase.database().reference().child("users").observeEventType(.childAdded, withBlock: {(snapchot) in
        //            if let dictionary = snapchot.value as? [String: AnyObject] {
        //                let user = User()
        //                user.setValuesForKeysWithDictionary(dictionary)
        //                self.users.append(user)
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //
        //
        //            }
        //            }, withCancelBlock: nil )
        
        var db : DatabaseReference!
        db = Database.database().reference().child("Chats")
        db.observe(.childAdded) { snapshot, err in
           
            if let chats = snapshot.value as? NSDictionary {
                let chatID = snapshot.key
                
                print(chats)
                print("💜💜💜")
                let users = chats["Users"] as! NSDictionary
                for user in users {
                    if user.value as! String == Auth.auth().currentUser?.uid {
                        
                       // let message = user["Message"]
                     //   let chatUser = user["Chat"]
                        
                        
//                        let newChat = Chat(id: snapshot.key, message: user["Message"], users: user["Users"])
                        self.users.append(chats)
                        self.tableView.reloadData()
                        let aa = self.users[0]["Users"] as! NSDictionary
                    }
                }
            }
                
        }
//        db = Database.database().reference().child("Chat").observe(.childAdded, with: { snapshot in
//            <#code#>
//        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return users.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let users = users[indexPath.row]["Users"] as! NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
//        let user = users[indexPath.row]
        cell.conversationLabel.text = users["first"] as! String == Auth.auth().currentUser?.uid ? users["seconde"] as! String : users["first"] as! String 
       // cell.conversationImage.image = UIImage(named: user.profileImage)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "chatView") as? ChatViewController {
//
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        }
        
        let sstoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let chatView = storyboard?.instantiateViewController(withIdentifier: "ChatView") as! ChatViewController
//        chatView.chatID = users[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//    class User: NSObject {
//        var name: String?
//        var image: UIImage?
//    }
