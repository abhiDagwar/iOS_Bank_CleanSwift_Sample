//
//  NetworkRouter.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 15/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

class NetworkRouter {
    enum Endpoints {
        static let base = "https://bank-app-test.herokuapp.com/api"
        
        case login
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.base + "/login"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}
