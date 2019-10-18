//
//  Statement.swift
//  CleanSwiftBankTestSample
//
//  Created by Shantanu on 18/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

struct AccountStatement: Codable {
    let statementList: [StatementList]
    let error: ErrorResponse
}

// MARK: - StatementList
struct StatementList: Codable {
    let title, desc, date: String
    let value: Double
}
