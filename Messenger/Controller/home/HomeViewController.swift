//
//  HomeViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var conversationArr = [String]()
   let users = [User]()
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
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return users.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let user = users[indexPath.row]
        cell.conversationLabel.text = user.fullName
        cell.conversationImage.image = UIImage(named: user.profileImage)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "chatView") as? ChatViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//    class User: NSObject {
//        var name: String?
//        var image: UIImage?
//    }
