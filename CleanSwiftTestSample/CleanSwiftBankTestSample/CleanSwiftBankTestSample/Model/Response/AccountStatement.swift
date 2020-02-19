//
//  Statement.swift
//  CleanSwiftBankTestSample
//
//  Created by Shantanu on 18/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

/**
 This file will parse the logged in user account statement details getting from statement API.
 
 - Parameters:
    - statementList: Get the user statement details
    - error: Get the error response if statement API is invalid or not successful.
 */

struct AccountStatement: Codable {
    let statementList: [StatementList]
    let error: ErrorResponse
}

// MARK: - StatementList
struct StatementList: Codable {
    let title, desc, date: String
    let value: Double
}
