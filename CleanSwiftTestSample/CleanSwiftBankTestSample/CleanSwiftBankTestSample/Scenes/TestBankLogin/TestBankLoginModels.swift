//
//  TestBankLoginModels.swift
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

enum TestBankLogin
{
  // MARK: Use cases
  
  enum Login
  {
    struct Request
    {
        var userID: String?
        var password: String?
    }
    struct Response
    {
        var success: Bool
        var loginResponse: LoginResponse
    }
    
    struct Error
    {
        var success: Bool
        var errorResponse: ErrorResponse
    }
    
    struct ViewModel
    {
        let success: Bool
        let loginResponse: LoginResponse
    }
    
    struct ErrorModel {
        let success: Bool
        let errorResponse: ErrorResponse
    }
    
  }
}
