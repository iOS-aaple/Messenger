//
//  ChatViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController , UITextFieldDelegate {
    
    
    //MARK: Connections
//    var user = User?
    var chat : Chat?
//    {
//        didSet{
//            navigationItem.title = user?.name
//        }
//    } should be in the didselect or something like that
    

    @IBOutlet weak var msgTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgTextField.delegate = self
        observeMesseges()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendAction(_ sender: Any) {
        handleSend()
    }
    
    
    func observeMesseges(){ //  i think this function should called in tableview class
        let ref = FIRDatabase.database().reference().child("Chat")
        ref.observeEventType(.childAdded, withBlock: {(snapshot) in
            user.id = snapshot.key // it acts as "user.value" but it displays only the key or id of that sender , not the user' info // this should be in the fetch func
            print(snapshot) // will print the messeges
        })
    }
    
    func handleSend(){
        let ref = FIRDatabase.database().reference().child("Chat") // i think it doesent work , maybe due to the import
        let childref = ref.childByAutoId() // not just update the messeges , it generate a list of messegees with uniqe id to each message
        let toID = user!.id! //  اليوزر اللي من فيو اللبيبل
        // not sure , it may works : chat?.fromID
        let fromID = FIRAuth.auth()?.currentUser?.uid
        let timestamp : NSNumber = Int(NSDate().timeIntervalSince1970)
        let values = ["text" : msgTextField.text! , "toId" : toID , "fromID" : fromID , "timestamp" : timestamp]
        // Chat(text: msgTextField.text!, toId: "\(toId)", fromID: "\(fromID)", timestamp: "\(timestamp)") // تجارب مو متاكده منها
        childref.updateChildValues(values)
    }
    
    func textFieldShouldReturn(textfield : UITextField)-> Bool{
        handleSend()
       return true
    }
    

}
