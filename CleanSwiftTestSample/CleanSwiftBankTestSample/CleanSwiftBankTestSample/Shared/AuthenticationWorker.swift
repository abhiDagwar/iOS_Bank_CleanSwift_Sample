//
//  AuthenticationWorker.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 13/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

class AuthenticationWorker
{    
    func login(username: String, password: String, completion: @escaping (Bool, LoginResponse?, ErrorResponse?) -> Void) {
        let body = LoginRequest(username: username, password: password)
        Network.taskForPOSTRequest(url: NetworkRouter.Endpoints.login.url, responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                completion(true, response, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func saveUserID(_ userID: String?)
    {
        UserDefaults.standard.set(userID, forKey: "userID")
    }
    
    func getUserID() -> String?
    {
        return UserDefaults.standard.string(forKey: "userID")
    }
}
