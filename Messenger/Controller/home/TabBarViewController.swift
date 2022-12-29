//
//  TabBarViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 29/12/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    var userID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("💚💚💚💚💚💚💚💚💚💚")
        print(userID)
        // Do any additional setup after loading the view.
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.tabBarController?.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))]
    }
    
    @objc func addTapped(){
        print("JJJ")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func gotoaccount(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let accountView = storyBoard.instantiateViewController(withIdentifier: "Account")
        present(accountView, animated: true)
    }
    
}
