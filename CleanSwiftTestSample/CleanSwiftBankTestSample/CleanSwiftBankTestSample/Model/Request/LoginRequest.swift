//
//  LoginRequest.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 16/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    /**
     This file adds login parameter to the login request when send to call login API to login to the application
     
     - important: Make sure you add both valid username and password to call parameters in the login API.
     - Parameters:
        - username: Enter a valid username to login
        - password: Enter a valid password to login
     */

    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "user"
        case password
    }
}
