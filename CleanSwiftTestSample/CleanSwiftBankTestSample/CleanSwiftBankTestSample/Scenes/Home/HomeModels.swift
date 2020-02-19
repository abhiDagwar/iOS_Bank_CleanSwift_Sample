//
//  HomeModels.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 13/10/19.
//  Copyright (c) 2019 Abhishek D. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

/**
 This class store all the models related to the controller. The Models class will be related to each component. It will be of type struct and mostly it will contain Request, Response, and ViewModel structs.
 
 Usage:
    - **Request** - Parameters that need to be sent to the API request.
    - **Response** - Intercepts the response from the API and stores the appropriate data.
    - **ViewModel** - Everything that you need to show to the UI is stored here.
 */
enum Home
{
    /**
     This `enum` store the user account details.
     */
    enum GetAccountHolderDetails
    {
        struct Request
        {
        }
        struct Response
        {
            var userAccountDetails: UserAccount
        }
        struct ViewModel
        {
            let name: String
            let bankAccountInfo: String
            let balance: Double
        }
    }
    
    /**
     This `enum` store the user account statement list details.
     */
    enum GetAccountStatementList
    {
        struct Request
        {
        }
        struct Response
        {
            var success: Bool
            var accountStatement: [StatementList]?
        }
        struct ViewModel
        {
            var success: Bool
            let statementList: [StatementList]?
            
            struct StatementList: Codable {
                let title: String
                let desc: String
                let date: String
                let value: Double
            }
        }
    }
}
