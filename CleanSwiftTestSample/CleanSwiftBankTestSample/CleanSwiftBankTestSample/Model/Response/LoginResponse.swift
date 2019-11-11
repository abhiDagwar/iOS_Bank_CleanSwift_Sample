//
//  Login.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 16/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

// MARK: - Login
struct LoginResponse: Codable {
    let userAccount: UserAccount
    let error: ErrorResponse
}

// MARK: - Error
struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = (try container.decodeIfPresent(Int.self, forKey: .code)) ?? -1
        message = (try container.decodeIfPresent(String.self, forKey: .message)) ?? "NA"
    }
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

// MARK: - UserAccount
struct UserAccount: Codable {
    let userID: Int
    let name, bankAccount, agency: String
    let balance: Double
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name, bankAccount, agency, balance
    }
}
