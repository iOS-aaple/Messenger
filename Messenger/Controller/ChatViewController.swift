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
class ChatViewController: UIViewController {
    
    
    //MARK: Connections
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var messagesTable: UITableView!
    
    var messages = [NSDictionary]()
    var receiver = String()
    var chatID = String()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTable.dataSource = self
        messagesTable.delegate = self
        
        observeMessage()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendAction(_ sender: Any) {
        
        let sendrID = Auth.auth().currentUser?.uid
        let ref: DatabaseReference!
            
      //  ref = Database.database().reference().child("Chats").child("\(UUID())").child("Users")
       // ref.setValue(["first":"\(receiver)","seconde":"\(Auth.auth().currentUser?.uid)"])
      //  ref.setValue(["Message":"","Users":""])
        
        ref = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
       let childRef = ref.childByAutoId()
           childRef.updateChildValues(["senderID":"\(sendrID!)","text" : msgTextField.text!,"time":"\(Date.timeIntervalBetween1970AndReferenceDate)"])
        msgTextField.text = ""
    }
    
    func observeMessage() {
        
        var ref:DatabaseReference!
        ref  = Database.database().reference().child("Chats").child("\(chatID)").child("Message")
        ref.observe(.childAdded) { snapshot , err in
            print("❤️")
            
            if let message = snapshot.value as? NSDictionary {
                print("❤️")
                print(message)
                self.messages.append(message)
                self.messagesTable.reloadData()
            
                print(self.messages)
            }
                
        }
    }
    
    
//    func textFieldShouldReturn(textfield : UITextField)-> Bool{
//        handleSend()
//       return true
//    }
    

}
extension ChatViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentID = Auth.auth().currentUser?.uid
        let senderID = messages[indexPath.row]["senderID"] as! String

        let cell = messagesTable.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath)
        cell.textLabel?.text = "\(messages[indexPath.row]["text"] as! String)"
        cell.backgroundColor = currentID == senderID ? UIColor.blue : UIColor.white
        return cell
    }


}
