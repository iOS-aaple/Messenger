//
//  Data.swift
//  Messenger
//
//  Created by Aamer Essa on 29/12/2022.
//

import Foundation


struct User: Codable {
    let fullName:String
    let email:String
    let password: String
    let profileImage: String
    let id : String
    let phoneNumber:String
}


struct Chat : Codable {
    let id :String
    let message : [Message]
    let users : User_
    
}


struct User_ : Codable {
    let first: String
    let second : String
   
    
}

struct Message: Codable {
    
    let sendrID: String
    let text: String
    let time: String
    
}
