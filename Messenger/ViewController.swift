//
//  ViewController.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//


import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit
import FirebaseCore
import GoogleSignIn

class ViewController: UIViewController {
   
//MARK: - outlet
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var errorMassage: UILabel!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var facbook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMassage.isHidden = true
//        facbook.delegate = self
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
           }
    }

    // MARK: - login
    
    @IBAction func login(_ sender: UIButton) {
        
        self.errorMassage.isHidden = true
        self.emailTextFiled.layer.borderWidth = 0.0
        self.passwordTextFiled.layer.borderWidth = 0.0
        self.emailTextFiled.layer.borderColor = UIColor.white.cgColor
        self.passwordTextFiled.layer.borderColor = UIColor.white.cgColor
        
        
        Auth.auth().signIn(withEmail: emailTextFiled.text!, password: passwordTextFiled.text!) { result, err in
            if err != nil {
                self.errorMassage.isHidden = false
                self.emailTextFiled.layer.borderWidth = 0.5
                self.passwordTextFiled.layer.borderWidth = 0.5
                self.emailTextFiled.layer.borderColor = UIColor.red.cgColor
                self.passwordTextFiled.layer.borderColor = UIColor.red.cgColor
                
            } else{
               
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeView = storyboard.instantiateViewController(withIdentifier: "TabBar") as! TabBarView
               let account = homeView.viewControllers![2] as! AccountViewController
                account.userID = "\(result!.user.uid)"
                homeView.modalPresentationStyle = .fullScreen
                self.present(homeView, animated: true)
            }
        }
    }
    
    //MARK: - Signup
    @IBAction func goToSingupView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let singupView = storyboard.instantiateViewController(withIdentifier: "SingupView")
        singupView.modalPresentationStyle = .fullScreen
        present(singupView, animated: true)
    }
    
    //MARK: - Forgot Password
    @IBAction func goToLoginView(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let forgotPassowrdView = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordView")
        forgotPassowrdView.modalPresentationStyle = .formSheet
        present(forgotPassowrdView, animated: true)
    }
    
    //MARK: - Facebook Login
    @IBAction func facebookLogin(_ sender: UIButton) {
       
           let loginManager = LoginManager()
           
           if let _ = AccessToken.current {
            
               loginManager.logOut()
               
           } else {
               
               loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                   guard error == nil else {
                       // Error occurred
                       print(error!.localizedDescription)
                       return
                   }
                   // Check for cancel
                   guard let result = result, !result.isCancelled else {
                       print("User cancelled login")
                       return
                   }
               
                   Profile.loadCurrentProfile { (profile, error) in
                     
                   }
               }
           }
    }
    //MARK: - Google Login
    func settUPGoogleLogin(){
//        Auth.auth().signIn(with: credential) { authResult, error in
//            if let error = error {
//              let authError = error as NSError
//              if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
//                // The user is a multi-factor user. Second factor challenge is required.
//                let resolver = authError
//                  .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//                var displayNameString = ""
//                for tmpFactorInfo in resolver.hints {
//                  displayNameString += tmpFactorInfo.displayName ?? ""
//                  displayNameString += " "
//                }
//                self.showTextInputPrompt(
//                  withMessage: "Select factor to sign in\n\(displayNameString)",
//                  completionBlock: { userPressedOK, displayName in
//                    var selectedHint: PhoneMultiFactorInfo?
//                    for tmpFactorInfo in resolver.hints {
//                      if displayName == tmpFactorInfo.displayName {
//                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                      }
//                    }
//                    PhoneAuthProvider.provider()
//                      .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
//                                         multiFactorSession: resolver
//                                           .session) { verificationID, error in
//                        if error != nil {
//                          print(
//                            "Multi factor start sign in failed. Error: \(error.debugDescription)"
//                          )
//                        } else {
//                          self.showTextInputPrompt(
//                            withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
//                            completionBlock: { userPressedOK, verificationCode in
//                              let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
//                                .credential(withVerificationID: verificationID!,
//                                            verificationCode: verificationCode!)
//                              let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
//                                .assertion(with: credential!)
//                              resolver.resolveSignIn(with: assertion!) { authResult, error in
//                                if error != nil {
//                                  print(
//                                    "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
//                                  )
//                                } else {
//                                  self.navigationController?.popViewController(animated: true)
//                                }
//                              }
//                            }
//                          )
//                        }
//                      }
//                  }
//                )
//              } else {
//                self.showMessagePrompt(error.localizedDescription)
//                return
//              }
//              // ...
//              return
//            }
//            // User is signed in
//            // ...
//        }
//
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
//
//          if let error = error {
//            // ...
//            return
//          }
//
//          guard
//            let authentication = user?.authentication,
//            let idToken = authentication.idToken
//          else {
//            return
//          }
//
//          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                         accessToken: authentication.accessToken)
//
//        }
    }
    
}

