//
//  NavigationViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 29/12/2022.
//

import UIKit

class NavigationViewController: UINavigationController {

    var userID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("❤️❤️❤️❤️❤️❤️")
        print(userID)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
      
        }
    @objc func addTapped(){
         print("HHH")
     }
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


