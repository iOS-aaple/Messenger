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
}


struct Chat : Codable {
    let text :String
    let toId : String
    let fromID : String
    let timestamp : String
}

