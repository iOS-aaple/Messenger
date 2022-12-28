//
//  PeopleViewController.swift
//  Messenger
//
//  Created by Munira on 28/12/2022.
//

import UIKit

class PeopleViewController: UIViewController {

    let data = [String]()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var filtereData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtereData = data
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    

    @IBAction func editingAction(_ sender: UITextField) {
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
                self.tableView.reloadData()
        
    }
    
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtereData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! peopleCell
        cell.cellID = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Chat", bundle: nil)
        let chatView = story.instantiateViewController(withIdentifier: "chatView") as! ChatViewController
        
        self.navigationController?.pushViewController(chatView, animated: true)
    }
    
    
}


