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
//        print("💚💚💚💚💚💚💚💚💚💚")
//        print(userID)
//        delegate = self
       
        
        // Do any additional setup after loading the view.
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
    }
    
   
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("❤️💛🧡")
//        if tabBar.selectedItem == 2{
//
//        }
//    }    /*
    // MARK: - Navigation

  
    
//    @IBAction func gotoaccount(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let accountView = storyBoard.instantiateViewController(withIdentifier: "Account")
//        present(accountView, animated: true)
//    }
    
}


//extension TabBarViewController:UITabBarControllerDelegate{
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if tabBarController.selectedIndex == 2 {
//            print("❤️💛🧡")
//
//            let currentVC = tabBarController.viewControllers
//            let accountView = currentVC![tabBarController.selectedIndex] as! AccountViewController
////            let accountView = currentVC.topViewController as! AccountViewController
//            print(accountView.userID)
//        }
//    }
//}
