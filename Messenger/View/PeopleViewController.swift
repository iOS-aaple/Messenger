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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filtereData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtereData = data
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
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

extension PeopleViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtereData = []
        
        if searchText == ""{
            filtereData = data
        }
        
        for name in data{
            if name.uppercased().contains(searchText.uppercased()){
                filtereData.append(name)
            }
        }
        self.tableView.reloadData()
    }
    
}
