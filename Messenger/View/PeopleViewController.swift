//
//  PeopleViewController.swift
//  Messenger
//
//  Created by Munira on 28/12/2022.
//

import UIKit

class PeopleViewController: UIViewController {

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
    
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtereUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! peopleCell
        cell.cellID = indexPath.row
        cell.friendName.text = filtereUser[indexPath.row].0
        cell.friendImage.image = UIImage(named: filtereUser[indexPath.row].1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}
