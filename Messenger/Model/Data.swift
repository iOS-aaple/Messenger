//
//  Data.swift
//  Messenger
//
//  Created by Aamer Essa on 28/12/2022.
//

import Foundation


struct User: Codable {
    let fullName:String
    let email:String
    let password: String
    let profileImage: String
    let id : String 
}
