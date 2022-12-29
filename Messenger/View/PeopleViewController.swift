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
class PeopleViewController: UIViewController {

    var users = [NSDictionary]()
    
    let data = [("Shaden","disco"),
                ("Aamer","disco-2"),
                ("Munira","disco"),
                ("Hasna", "disco"),
                ("Mohammed","disco-2")]
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var filtereUser = [("Shaden","disco"),
                       ("Aamer","disco-2"),
                       ("Munira","disco"),
                       ("Hasna", "disco"),
                       ("Mohammed","disco-2")]
       // let userImage = ["disco", "disco-2", "disco", "disco", "disco-2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtereUser = data
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fethData()
    }
    

    @IBAction func editingAction(_ sender: UITextField) {
        filtereUser = []
        
        if sender.text == ""{
            filtereUser = data
        } else {
            for name in data{
                if name.0.uppercased().contains((sender.text?.uppercased())!){
                    filtereUser.append(name)
                }
            }
        }
        self.tableView.reloadData()
        
        /*
        filtereData = []
                
                if sender.text == ""{
                    filtereData = data
                } else {
                    for name in data{
                        if name.uppercased().contains((sender.text?.uppercased())!){
                            filtereData.append(name)
                        }
                    }
                }
                self.tableView.reloadData()*/
        
    }
    
   func fethData(){
       
       var db: DatabaseReference!
        db = Database.database().reference()
        // var userInfo = NSArray()
//       db.child("users").observe(.value) { result,err in
//           if err != nil {
//               print("error")
//           }
//           else{
//               if let userInfo = result.value as? NSDictionary {
//
//                   for user in userInfo {
//                       print(user.value["email"])
//                   }
//
//               }
//           }
       db.child("users").observe(.value) { resualt,err in
           
           let users = resualt.value as! NSDictionary
           for user in users{
               let user = user.value as! NSDictionary
               self.users.append(user)
               
       }
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
           print(self.users)
       
           
//               for user in usersInfo {
//                   let userDict = user as! NSDictionary
//                   self.users.append(userDict)
//
//               }
               
            
          // }
       }
    }
    
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // filtereUser.count
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! peopleCell
       // cell.cellID = indexPath.row
//        cell.friendName.text = filtereUser[indexPath.row].0
//        cell.friendImage.image = UIImage(named: filtereUser[indexPath.row].1)
        cell.friendName.text = users[indexPath.row]["fullName"] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}
