//
//  LoginRequest.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 16/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "user"
        case password
    }
}
